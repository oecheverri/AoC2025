//
//  Day05.swift
//  AoC2025
//
//  Created by Oscar Echeverri on 2025-12-06.
//
import Foundation

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

    func mergeOverlappingRanges(_ ranges: [ClosedRange<Int>]) -> [ClosedRange<Int>] {

        guard ranges.count > 1 else {
            return ranges
        }
        let sortedRanges = ranges.sorted { $0.lowerBound < $1.lowerBound }
        var mergedRanges: [ClosedRange<Int>] = []
        for range in sortedRanges {

            let mergeInto = mergedRanges.last

            guard let mergeInto,
                mergeInto.overlaps(range),
                let merged = mergeInto.union(with: range)
            else {
                mergedRanges.append(range)
                continue
            }

            mergedRanges[mergedRanges.endIndex.advanced(by: -1)] = merged
        }

        return mergedRanges
    }

    public func solvePart2() -> Int {
        mergeOverlappingRanges(ranges)
            .reduce(0) { $0 + $1.count }
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

extension ClosedRange where Bound == Int {
    func union(with other: Self) -> Self? {
        guard self.overlaps(other) || self.upperBound == other.lowerBound - 1 || other.upperBound == self.lowerBound - 1 else {
            return nil  // disjoint ranges can't form a single ClosedRange
        }

        return Swift.min(self.lowerBound, other.lowerBound)
            ... Swift.max(self.upperBound, other.upperBound)
    }
}
