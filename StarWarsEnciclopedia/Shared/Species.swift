//
//  Species.swift
//  StarWarsEnciclopedia
//
//  Created by Francisco Ruiz on 04/02/22.
//

import Foundation

struct Specie: Codable {
    let name: String
    let classification: String
    let designation: String
    let average_height: String
    let skin_colors: String
    let hair_colors: String
    let eye_colors: String
    let average_lifespan: String
    let homeworld: String?
    let language: String
    let people: [String]
    let films: [String]
    let created: String
    let edited: String
    let url: String
    
    var number: Int {
        return Int(url
            .replacingOccurrences(of: "https://swapi.dev/api/species/", with: "")
            .replacingOccurrences(of: "/", with: "")) ?? 0
    }
}

class Species: ObservableObject {
    @Published var species = [Specie]()
    
    func loadSpecies(urls: [String]) async {
        for url in urls {
            guard let apiUrl = URL(string: url) else { continue }
            
            print("URL Specie: \(apiUrl)")
            
            var request = URLRequest(url: apiUrl)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpMethod = "GET"
            
            do {
                let (data, _) = try await URLSession.shared.data(for: request)
                let decodedSpecie = try JSONDecoder().decode(Specie.self, from: data)
                
                await MainActor.run {
                    self.species.append(decodedSpecie)
                }
            } catch {
                print("Error loading specie")
            }
        }
    }
}
