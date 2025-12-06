//
//  Day04.swift
//  AoC2025
//
//  Created by Oscar Echeverri on 2025-12-04.
//

public struct Day04: Solution {

    public let day = 5
    public let year = 2025

    let rollGrid: [[Bool]]

    public init(input: String) {
        rollGrid =
            input
            .components(separatedBy: .newlines)
            .map { line in
                line.map { $0 != "@" }
            }
    }

    public func solvePart1() -> Int {
        rollGrid.enumerated().reduce(0) {
            let (rowIndx, row) = $1
            return row.indices.reduce($0) {
                $0 + (rollGrid.isForkliftAccessible(row: rowIndx, col: $1) ? 1 : 0)
            }
        }
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

    func moveRolls(in grid: inout [[Bool]]) -> Int {
        let snapshot = grid
        var moved = 0
        return snapshot.enumerated().reduce(0) {
            let (rowIndx, row) = $1
            return row.indices.reduce($0) {

                if snapshot.isForkliftAccessible(row: rowIndx, col: $1) {
                    grid[rowIndx][$1] = true
                    moved += 1
                    return $0 + 1
                }

                return $0
            }
        }
    }

}

extension Array where Element == [Bool] {

    func isForkliftAccessible(row: Int, col: Int) -> Bool {

        guard !self[row][col] else { return false }

        var trueNeighbours = 0

        // up
        if row > 0, !self[row - 1][col] { trueNeighbours += 1 }

        // down
        if row < self.count - 1, !self[row + 1][col] { trueNeighbours += 1 }

        // left
        if col > 0, !self[row][col - 1] { trueNeighbours += 1 }

        // right
        if col < self[row].count - 1, !self[row][col + 1] { trueNeighbours += 1 }

        // up left
        if row > 0, col > 0, !self[row - 1][col - 1] { trueNeighbours += 1 }

        // up right
        if row > 0, col < self[row].count - 1, !self[row - 1][col + 1] { trueNeighbours += 1 }

        // down left
        if row < self.count - 1, col > 0, !self[row + 1][col - 1] { trueNeighbours += 1 }

        //dow right
        if row < self.count - 1, col < self[row].count - 1, !self[row + 1][col + 1] { trueNeighbours += 1 }

        return trueNeighbours < 4

    }

}
