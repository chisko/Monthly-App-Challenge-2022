//
//  StarWarsEnciclopediaApp.swift
//  Shared
//
//  Created by Francisco Ruiz on 03/02/22.
//

import SwiftUI

@main
struct StarWarsEnciclopediaApp: App {
    
    let peopleRes = PeopleRes()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(peopleRes)
        }
    }
}
