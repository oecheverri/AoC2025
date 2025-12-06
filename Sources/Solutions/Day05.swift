//
//  Day05.swift
//  AoC2025
//
//  Created by Oscar Echeverri on 2025-12-06.
//

public struct Day05: Solution {
    public let year: Int = 2025

    public let day: Int = 5

    let ranges: [ClosedRange<Int>]
    let ingredients: [Int]

    public init(input: String) {
        let components =
            input
            .components(separatedBy: .newlines)
            .split(separator: "")

        ranges = components[0]
            .map {
                $0.components(separatedBy: "-")
                    .compactMap(Int.init)
            }
            .map {
                $0[0] ... $0[1]
            }

        ingredients = components[1]
            .compactMap(Int.init)

    }

    public func solvePart1() -> Int {
        ingredients.count(where: isFresh(ingredient:))
    }

    public func solvePart2() -> Int {
        0
    }

    func isFresh(ingredient: Int) -> Bool {
        for range in ranges {
            if range.contains(ingredient) {
                return true
            }
        }
        return false
    }

}
