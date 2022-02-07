//
//  People.swift
//  StarWarsEnciclopedia
//
//  Created by Francisco Ruiz on 04/02/22.
//

import Foundation

struct People: Codable {
    let name: String
    let height: String
    let mass: String
    let hair_color: String
    let skin_color: String
    let eye_color: String
    let birth_year: String
    let gender: String
    let homeworld: String
    let films: [String]
    let species: [String]
    let vehicles: [String]
    let starships: [String]
    let created: String
    let edited: String
    let url: String
    
    var number: Int {
        return Int(url
            .replacingOccurrences(of: "https://swapi.dev/api/people/", with: "")
            .replacingOccurrences(of: "/", with: "")) ?? 0
    }
}

struct PeopleResponse: Codable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [People]
    
    var hasBefore: Bool {
        if previous != nil {
            return true
        } else {
            return false
        }
    }
}

class PeopleRes: ObservableObject {
    @Published var page = 1
    @Published var count = 0
    @Published var disablePrevious = true
    @Published var disableNext = true
    @Published var people = [People]()
    
    private var search = ""
    
    func previosPage() async {
        guard page > 1 else { return }
        
        self.page -= 1
        await self.loadPeople()
    }
    
    func nextPage() async {
        self.page += 1
        await self.loadPeople()
    }
    
    func search(_ search: String) async {
        self.search = search
        self.page = 1
        await self.loadPeople()
    }
    
    func clearSearch() async {
        self.search = ""
        self.page = 1
        await self.loadPeople()
    }
    
    func loadPeople() async {
        var getParams = ""
        if self.page > 1 {
            getParams = "?page=\(self.page)"
        }
        
        if self.search != "" {
            getParams += getParams.isEmpty ? "?" : "&"
            getParams += "search=\(self.search)"
        }
        
        guard let apiUrl = URL(string: "https://swapi.dev/api/people/\(getParams)") else { return }
        
        print("URL: \(apiUrl)")
        
        var request = URLRequest(url: apiUrl)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let decodedPeople = try JSONDecoder().decode(PeopleResponse.self, from: data)
            
            await MainActor.run {
                self.count = decodedPeople.count
                self.disablePrevious = decodedPeople.previous == nil
                print("NEXT: \(decodedPeople.next)")
                self.disableNext = decodedPeople.next == nil
                self.people = decodedPeople.results
            }
        } catch {
            print("Error loading people")
        }
    }
}
