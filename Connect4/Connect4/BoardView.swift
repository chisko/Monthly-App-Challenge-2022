//
//  BoardView.swift
//  Connect4
//
//  Created by Francisco Ruiz on 19/01/22.
//

import SwiftUI

struct BoardView: View {
    @EnvironmentObject var boardMoves: BoardMoves
    
    var body: some View {
        VStack {
            VStack {
                GeometryReader { geo in
                    self.printBoard(size: geo.size)
                }
                .padding()
            }
            .padding(.top, 10)
            .background(
                boardMoves.gamePlaying == false
                ? .blue.opacity(0.25)
                : boardMoves.activePlayer == 1
                ? .red.opacity(0.25)
                : .yellow.opacity(0.25)
            )
            
            Spacer()
            
            VStack {
                Text(
                    boardMoves.isTie
                    ? "It´s a tie..."
                    :"Player \(boardMoves.activePlayer) WINs!"
                )
                    .font(.title2.bold())
                    .padding()
                    .foregroundColor(.white)
                    .background(
                        boardMoves.isTie
                        ? .black.opacity(0.25)
                        : boardMoves.activePlayer == 1 ? .red : .yellow
                    )
                    .clipShape(Capsule(style: .continuous))
            
                HStack {
                    Button {
                        boardMoves.playAgain()
                    } label: {
                        Text("Play Again")
                            .padding()
                            .frame(width: 150)
                            .foregroundColor(.white)
                            .background(.blue)
                            .clipShape(Capsule())
                    }
                    
                    Spacer()
                    
                    Button {
                        boardMoves.reset()
                    } label: {
                        Text("Reset")
                            .padding()
                            .frame(width: 150)
                            .foregroundColor(.white)
                            .background(.blue)
                            .clipShape(Capsule())
                    }
                }
                .padding()
            }
            .opacity(
                boardMoves.gamePlaying
                ? 0.0
                : 1.0
            )
        }
    }
    
    func printBoard(size: CGSize) -> some View {
        let cellSideLength = size.width/CGFloat(ContentView.cols)
        return HStack(spacing: 2) {
            self.printCells(cellSideLength: cellSideLength)
        }
        .frame(
            width: cellSideLength * CGFloat(ContentView.cols),
            height: cellSideLength * CGFloat(ContentView.rows)
        )
        
    }
    
    func printCells(cellSideLength: CGFloat) -> some View {
        ForEach(0 ..< ContentView.cols) { x in
            VStack(spacing: 2) {
                ForEach(0 ..< ContentView.rows) { y in
                    Button {
                        boardMoves.addMove(x: x, y: y)
                    } label: {
                        //Text("(\(x),\(y))")
                        Text(" ")
                            .font(.caption)
                            .frame(width: cellSideLength - 10, height: cellSideLength - 10)
                            .background(
                                boardMoves.moves[x][y].isActive
                                ? boardMoves.moves[x][y].player == 1 ? .red : .yellow
                                : .white
                            )
                            .cornerRadius(cellSideLength - 10)
                            .padding(5)
                            .background(.blue)
                            .cornerRadius(5)
                    }
                }
            }
            .frame(
                width: cellSideLength
            )
        }
    }
}

struct BoardView_Previews: PreviewProvider {
    static var previews: some View {
        BoardView()
    }
}
