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

    func findNLargestDigits(in array: [Int], n: Int) -> [Int] {

        guard array.count >= n else { return [] }

        var remainingSkips = array.count - n

        var result = [Int]()

        var currentIndex = result.startIndex
        while result.count < n {
            let maxIndex = array.indices[currentIndex ... currentIndex + remainingSkips].max { array[$0] < array[$1] }
            guard let maxIndex else { return [] }
            remainingSkips += array.distance(from: maxIndex, to: currentIndex)
            result.append(array[maxIndex])
            currentIndex = maxIndex + 1
        }

        return result
    }

    public func solvePart1() -> Int {
        banks
            .map(findMaxValue)
            .reduce(0, +)
    }

    public func solvePart2() -> Int {
        banks
            .map { findNLargestDigits(in: $0, n: 12).asSingleInt }
            .reduce(0, +)
    }

}
