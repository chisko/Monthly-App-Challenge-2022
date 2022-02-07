//
//  Starships.swift
//  StarWarsEnciclopedia
//
//  Created by Francisco Ruiz on 04/02/22.
//

import Foundation
/*
 "name": "X-wing",
 "model": "T-65 X-wing",
 "manufacturer": "Incom Corporation",
 "cost_in_credits": "149999",
 "length": "12.5",
 "max_atmosphering_speed": "1050",
 "crew": "1",
 "passengers": "0",
 "cargo_capacity": "110",
 "consumables": "1 week",
 "hyperdrive_rating": "1.0",
 "MGLT": "100",
 "starship_class": "Starfighter",
 "pilots": [
     "https://swapi.dev/api/people/1/"
 ],
 "films": [
     "https://swapi.dev/api/films/1/"
 ],
 "created": "2014-12-12T11:19:05.340000Z",
 "edited": "2014-12-20T21:23:49.886000Z",
 "url": "https://swapi.dev/api/starships/12/"
 */
struct Starship: Codable {
    let name: String
    let model: String
    let manufacturer: String
    let cost_in_credits: String
    let length: String
    let max_atmosphering_speed: String
    let crew: String
    let passengers: String
    let cargo_capacity: String
    let consumables: String
    let hyperdrive_rating: String
    let MGLT: String
    let starship_class: String
    let pilots: [String]
    let films: [String]
    let created: String
    let edited: String
    let url: String
    
    var number: Int {
        return Int(url
            .replacingOccurrences(of: "https://swapi.dev/api/starships/", with: "")
            .replacingOccurrences(of: "/", with: "")) ?? 0
    }
}

class Starships: ObservableObject {
    @Published var starships = [Starship]()
    
    func loadStarships(urls: [String]) async {
        for url in urls {
            guard let apiUrl = URL(string: url) else { continue }
            
            print("URL Starship: \(apiUrl)")
            
            var request = URLRequest(url: apiUrl)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpMethod = "GET"
            
            do {
                let (data, _) = try await URLSession.shared.data(for: request)
                let decodedStarship = try JSONDecoder().decode(Starship.self, from: data)
                
                await MainActor.run {
                    self.starships.append(decodedStarship)
                }
            } catch {
                print("Error loading starship")
            }
        }
    }
}
