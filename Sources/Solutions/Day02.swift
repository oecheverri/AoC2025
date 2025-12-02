//
//  Day02.swift
//  AoC2025
//
//  Created by Oscar Echeverri on 2025-12-02.
//
import Foundation

public struct Day02: Solution {

    public var day: Int { 2 }
    public var year: Int { 2025 }

    let numbers: [Int]

    public init(input: String) {
        numbers =
            input
            .components(separatedBy: ",")
            .map {
                $0.components(separatedBy: "-")
            }
            .flatMap {
                ClosedRange(uncheckedBounds: (Int($0[0])!, Int($0[1])!))
                    .map(\.self)
            }

    }

    private func getDivisor(_ n: Int) -> Int {
        let value = round(log10(Double(n)) / log10(100.0))

        return Int(pow(10, value))
    }

    func isValid(_ n: Int) -> Bool {

        let divisor = getDivisor(n)

        let leftHalf = Int(n / divisor)
        let rightHalf = n - (leftHalf * divisor)

        return leftHalf != rightHalf

    }

    func isInvalid(_ n: Int) -> Bool {
        !isValid(n)
    }

    public func solvePart1() -> Int {
        numbers
            .filter(isInvalid(_:))
            .reduce(0, +)
    }

    public func solvePart2() -> Int {
        return 0
    }
}
