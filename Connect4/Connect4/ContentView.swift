//
//  ContentView.swift
//  Connect4
//
//  Created by Francisco Ruiz on 19/01/22.
//

import SwiftUI

struct ContentView: View {
    static let rows = 6
    static let cols = 7
    
    @EnvironmentObject var boardMoves: BoardMoves
    
    var body: some View {
        VStack {
            Spacer()
            
            Image("connect4")
                .resizable()
                .scaledToFit()
                .frame(height: 150)
            
            Spacer()
            
            HStack {
                Spacer()
                
                VStack {
                    Text("Player 1")
                    Text("\(boardMoves.player1Wins) win\(boardMoves.player1Wins > 1 ? "s" : "")")
                }
                .padding()
                .foregroundColor(.white)
                .background(.red)
                .clipShape(Capsule(style: .continuous))
                
                Spacer()
                
                VStack {
                    Text("Ties")
                    Text("\(boardMoves.ties) tie\(boardMoves.ties > 1 ? "s" : "")")
                }
                .padding()
                .foregroundColor(.white)
                .background(.black.opacity(0.25))
                .clipShape(Capsule(style: .continuous))
                .opacity(
                    boardMoves.ties == 0
                    ? 0
                    : 1
                )
                
                Spacer()
                
                VStack {
                    Text("Player 2")
                    Text("\(boardMoves.player2Wins) win\(boardMoves.player2Wins > 1 ? "s" : "")")
                }
                .padding()
                .foregroundColor(.white)
                .background(.yellow)
                .clipShape(Capsule(style: .continuous))
                
                Spacer()
            }
            .padding(.horizontal)
            
            Spacer()
            
            BoardView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
