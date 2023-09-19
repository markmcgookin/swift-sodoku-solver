//
//  ContentView.swift
//  sodoku-solver
//
//  Created by Mark McGookin on 19/09/2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Button("Test") {
                if solvePuzzle(&sudokuBoard_evil) {
                    // Print the solved Sudoku puzzle
                    for row in sudokuBoard_evil {
                        print(row)
                    }
                } else {
                    print("No solution exists.")
                }
            }
        }
        .padding()
    }
}

var sudokuBoard_empty: [[Character]] = [
    [".",".",".",".",".",".",".",".","."],
    [".",".",".",".",".",".",".",".","."],
    [".",".",".",".",".",".",".",".","."],
    [".",".",".",".",".",".",".",".","."],
    [".",".",".",".",".",".",".",".","."],
    [".",".",".",".",".",".",".",".","."],
    [".",".",".",".",".",".",".",".","."],
    [".",".",".",".",".",".",".",".","."],
    [".",".",".",".",".",".",".",".","."]
]

var sudokuBoard_hard: [[Character]] = [
    [".",".",".","7","5",".",".",".","."],
    [".",".",".","2",".","8",".","4","5"],
    [".","5",".",".",".",".",".",".","2"],
    [".","7",".",".",".","1",".",".","."],
    ["8",".","1",".","4","9","2",".","7"],
    [".",".","9",".","2",".","6",".","."],
    ["4","1",".",".",".",".",".",".","8"],
    [".",".","3",".",".",".","4",".","."],
    [".",".","8",".",".","4","5","6","."]
]

var sudokuBoard_evil: [[Character]] = [
    ["1","7",".","4",".","5",".",".","9"],
    [".",".",".",".","2",".","4",".","."],
    [".",".","5",".","6",".",".",".","."],
    [".",".",".",".","5",".",".",".","."],
    [".",".","7","3",".","1","6",".","."],
    [".","9",".",".",".",".",".","8","."],
    [".",".",".","2",".",".",".",".","."],
    ["3",".",".",".",".",".",".",".","6"],
    [".",".","1","7",".","4","3",".","."]
]

func solvePuzzle(_ board: inout [[Character]]) -> Bool {
    for i in 0..<9 {
        for j in 0..<9 {
            if board[i][j] == "." {
                for num in "123456789" {
                    if isValid(board, i, j, num) {
                        board[i][j] = num
                        if solvePuzzle(&board) {
                            return true
                        }
                        board[i][j] = "."
                    }
                }
                return false
            }
        }
    }
    return true
}

func isValid(_ board: [[Character]], _ row: Int, _ col: Int, _ num: Character) -> Bool {
    for i in 0..<9 {
        if board[row][i] == num || board[i][col] == num || board[row - row % 3 + i / 3][col - col % 3 + i % 3] == num {
            return false
        }
    }
    return true
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
