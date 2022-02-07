//
//  Vehicles.swift
//  StarWarsEnciclopedia
//
//  Created by Francisco Ruiz on 04/02/22.
//

import Foundation

struct Vehicle: Codable {
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
    let vehicle_class: String
    let pilots: [String]
    let films: [String]
    let created: String
    let edited: String
    let url: String
    
    var number: Int {
        return Int(url
            .replacingOccurrences(of: "https://swapi.dev/api/vehicles/", with: "")
            .replacingOccurrences(of: "/", with: "")) ?? 0
    }
}

class Vehicles: ObservableObject {
    @Published var vehicles = [Vehicle]()
    
    func loadVehicles(urls: [String]) async {
        for url in urls {
            guard let apiUrl = URL(string: url) else { continue }
            
            print("URL Vehicle: \(apiUrl)")
            
            var request = URLRequest(url: apiUrl)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpMethod = "GET"
            
            do {
                let (data, _) = try await URLSession.shared.data(for: request)
                let decodedVehicle = try JSONDecoder().decode(Vehicle.self, from: data)
                
                await MainActor.run {
                    self.vehicles.append(decodedVehicle)
                }
            } catch {
                print("Error loading specie")
            }
        }
    }
}
