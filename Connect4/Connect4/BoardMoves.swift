//
//  BoardMoves.swift
//  Connect4
//
//  Created by Francisco Ruiz on 19/01/22.
//

import Foundation

struct Move {
    var isActive: Bool
    var player: Int
}

class BoardMoves: ObservableObject {
    @Published private(set) var moves: [[Move]] = []
    @Published private(set) var activePlayer: Int
    
    @Published private(set) var gamePlaying: Bool
    @Published private(set) var isTie: Bool
    
    @Published private(set) var player1Wins: Int = 0
    @Published private(set) var player2Wins: Int = 0
    @Published private(set) var ties: Int = 0
    
    init() {
        let cols = ContentView.cols
        let rows = ContentView.rows
        
        self.gamePlaying = true
        self.isTie = false
        self.activePlayer = 1
        
        self.moves = Array(repeating: Array(repeating: Move(isActive: false, player: 0), count: rows), count: cols)
        self.reset()
        
        //self.moves[0][5] = Move(isActive: true, player: 1)
        //self.moves[1][5] = Move(isActive: true, player: 1)
    }
    
    func reset() {
        self.gamePlaying = true
        self.isTie = false
        self.player1Wins = 0
        self.player2Wins = 0
        
        for j in 0 ..< ContentView.rows {
            for i in 0 ..< ContentView.cols {
                self.moves[i][j] = Move(isActive: false, player: 0)
            }
        }
    }
    
    func playAgain() {
        self.gamePlaying = true
        self.isTie = false
        
        for j in 0 ..< ContentView.rows {
            for i in 0 ..< ContentView.cols {
                self.moves[i][j] = Move(isActive: false, player: 0)
            }
        }
    }
    
    func addMove(x: Int, y: Int) {
        guard self.gamePlaying else { return }
        
        // Obtener celda vacia de esa columna
        let colCells = (0 ..< ContentView.rows).reversed()
        for j in colCells {
            if self.moves[x][j].isActive == false {
                self.moves[x][j] = Move(isActive: true, player: self.activePlayer)
                
                if didWin() {
                    self.addWinToPlayer()
                    self.gamePlaying = false
                    print("You win!")
                } else if didTie() {
                    self.ties += 1
                    self.isTie = true
                    self.gamePlaying = false
                } else {
                    self.changeActivePlayer()
                }
                
                break
            }
        }
    }
    
    func addWinToPlayer() {
        if activePlayer == 1 {
            self.player1Wins += 1
        } else {
            self.player2Wins += 1
        }
    }
    
    func changeActivePlayer() {
        if self.activePlayer == 1 {
            self.activePlayer = 2
        } else {
            self.activePlayer = 1
        }
    }
    
    private func didWin() -> Bool {
        for x in 0 ..< ContentView.cols {
            for y in 0 ..< ContentView.rows {
                // Revisar que celda sea activa y del jugador activo
                guard self.moves[x][y].isActive && self.moves[x][y].player == self.activePlayer else {
                    continue
                }
                
                // Revisar hacia la izquierda
                if winRight(x: x, y: y) {
                    return true
                }
                
                // Revisar hacia abajo
                if winDown(x: x, y: y) {
                    return true
                }
                
                // Revisar en diagonal hacia arriba
                if winDiagUp(x: x, y: y) {
                    return true
                }
                
                // Revisar en diagonal hacia abajo
                if winDiagDown(x: x, y: y) {
                    return true
                }
            }
        }
        
        return false
    }
    
    private func winRight(x: Int, y: Int) -> Bool {
        // Validar hasta la columna N - 4
        if x + 4 > ContentView.cols { return false }
        
        // Validar desde la celda actual y hasta 4 posiciones a la derecha
        for x1 in x ..< x + 4 {
            if self.moves[x1][y].isActive == false || self.moves[x1][y].player != activePlayer {
                return false
            }
        }
        
        return true
    }
    
    private func winDown(x: Int, y: Int) -> Bool {
        // Validar hasta la fila N - 4
        if y + 4 > ContentView.rows { return false }
        
        // Validar desde la celda actual y hasta 4 posiciones hacia abajo
        for y1 in y ..< y + 4 {
            if self.moves[x][y1].isActive == false || self.moves[x][y1].player != activePlayer {
                return false
            }
        }
        
        return true
    }
    
    private func winDiagUp(x: Int, y: Int) -> Bool {
        // Validar que el inicio este dentro de donde pueden haber 4 en diagonal hacia arriba
        if x + 4 > ContentView.cols { return false }
        if y < 3 { return false }
        
        // Validar desde la celda actual y 4 posiciones en diagonal hacia arriba
        for d in 0 ... 3 {
            if self.moves[x + d][y - d].isActive == false || self.moves[x + d][y - d].player != activePlayer {
                return false
            }
        }
        
        return true
    }
    
    private func winDiagDown(x: Int, y: Int) -> Bool {
        // Validar que el inicio este dentro de donde pueden haber 4 en diagonal hacia abajo
        if x > ContentView.cols - 4 { return false }
        if y > ContentView.rows - 4 { return false }
        
        for d in 0 ... 3 {
            if self.moves[x + d][y + d].isActive == false || self.moves[x + d][y + d].player != activePlayer {
                return false
            }
        }
        
        return true
    }
    
    private func didTie() -> Bool {
        for x in 0 ..< ContentView.cols {
            for y in 0 ..< ContentView.rows {
                if self.moves[x][y].isActive == false {
                    return false
                }
            }
        }
        
        return true
    }
}
