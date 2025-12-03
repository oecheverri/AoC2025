//
//  Day03.swift
//  AoC2025
//
//  Created by Oscar Echeverri on 2025-12-03.
//

public struct Day03: Solution {

    public var year: Int { 2025 }
    public var day: Int { 3 }

    let banks: [[Int]]

    public init(input: String) {
        banks =
            input
            .components(separatedBy: .newlines)
            .map { $0.compactMap(\.wholeNumberValue) }

    }

    func findMaxValue(in bank: [Int]) -> Int {

        var tens = bank[0]
        var ones = bank[1]

        for i in 1 ..< bank.count {
            if bank[i] > tens && i < bank.count - 1 {
                tens = bank[i]
                ones = bank[i + 1]
            } else if bank[i] > ones {
                ones = bank[i]
            }

        }

        return tens * 10 + ones
    }

    public func solvePart1() -> Int {
        banks
            .map(findMaxValue)
            .reduce(0, +)
    }

    public func solvePart2() -> Int {
        0
    }

}
