//
//  Day04.swift
//  AoC2025
//
//  Created by Oscar Echeverri on 2025-12-04.
//

public struct Day04: Solution {

    public let day = 4
    public let year = 2025

    let rollGrid: [[Cell]]

    public init(input: String) {
        rollGrid =
            input
            .components(separatedBy: .newlines)
            .filter { !$0.isEmpty }
            .map {
                $0.map {
                    switch $0 {
                        case "@":
                            return .Roll
                        case ".":
                            return .Empty
                        default:
                            fatalError("Unexpected character: \($0)")
                    }
                }
            }
    }

    public func solvePart1() -> Int {
        var moved = 0
        for rowIdx in rollGrid.indices {
            for colIdx in rollGrid[rowIdx].indices {
                if rollGrid.isRollForkliftAccessible(row: rowIdx, col: colIdx) {
                    moved += 1
                }
            }
        }
        return moved
    }

    public func solvePart2() -> Int {
        var mutableGrid = rollGrid

        var accumulated = 0
        while true {
            let moved = moveRolls(in: &mutableGrid)
            guard moved > 0 else { break }
            accumulated += moved
        }

        return accumulated

    }

    func moveRolls(in grid: inout [[Cell]]) -> Int {
        let snapshot = grid
        var moved = 0
        for rowIdx in snapshot.indices {
            for colIdx in snapshot[rowIdx].indices {
                if snapshot.isRollForkliftAccessible(row: rowIdx, col: colIdx) {
                    grid[rowIdx][colIdx] = .Empty
                    moved += 1
                }
            }
        }
        return moved
    }

}

enum Cell {
    case Roll
    case Empty
}

extension Array where Element == [Cell] {

    @inline(__always) func isRollForkliftAccessible(row: Int, col: Int) -> Bool {
        guard self[row][col] == .Roll else { return false }

        var rollNeighbours = 0

        // up
        if row > 0, self[row - 1][col] == .Roll { rollNeighbours += 1 }

        // down
        if row < self.count - 1, self[row + 1][col] == .Roll { rollNeighbours += 1 }

        // left
        if col > 0, self[row][col - 1] == .Roll { rollNeighbours += 1 }

        // right
        if col < self[row].count - 1, self[row][col + 1] == .Roll { rollNeighbours += 1 }

        // up left
        if row > 0, col > 0, self[row - 1][col - 1] == .Roll { rollNeighbours += 1 }

        // up right
        if row > 0, col < self[row].count - 1, self[row - 1][col + 1] == .Roll { rollNeighbours += 1 }

        // down left
        if row < self.count - 1, col > 0, self[row + 1][col - 1] == .Roll { rollNeighbours += 1 }

        // down right
        if row < self.count - 1, col < self[row].count - 1, self[row + 1][col + 1] == .Roll { rollNeighbours += 1 }

        return rollNeighbours < 4
    }
}
