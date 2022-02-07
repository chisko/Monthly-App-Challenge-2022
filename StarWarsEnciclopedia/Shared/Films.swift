//
//  Films.swift
//  StarWarsEnciclopedia
//
//  Created by Francisco Ruiz on 04/02/22.
//

import Foundation

struct Film: Codable {
    let title: String
    let episode_id: Int
    let opening_crawl: String
    let director: String
    let producer: String
    let release_date: String
    let characters: [String]
    let planets: [String]
    let starships: [String]
    let vehicles: [String]
    let species: [String]
    let created: String
    let edited: String
    let url: String
}

class Films: ObservableObject {
    @Published var films = [Film]()
    
    func loadFilms(urls: [String]) async {
        for url in urls {
            guard let apiUrl = URL(string: url) else { continue }
            
            print("URL Film: \(apiUrl)")
            
            var request = URLRequest(url: apiUrl)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpMethod = "GET"
            
            do {
                let (data, _) = try await URLSession.shared.data(for: request)
                let decodedFilm = try JSONDecoder().decode(Film.self, from: data)
                
                await MainActor.run {
                    self.films.append(decodedFilm)
                }
            } catch {
                print("Error loading film")
            }
        }
    }
}
