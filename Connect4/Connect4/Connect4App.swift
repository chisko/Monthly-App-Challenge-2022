//
//  Connect4App.swift
//  Connect4
//
//  Created by Francisco Ruiz on 19/01/22.
//

import SwiftUI

@main
struct Connect4App: App {
    var boardMoves = BoardMoves()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(boardMoves)
        }
    }
}
