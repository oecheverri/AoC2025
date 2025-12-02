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

    let numbers: [[Int]]

    public init(input: String) {
        numbers =
            input
            .components(separatedBy: ",")
            .map {
                $0.components(separatedBy: "-")
            }
            .compactMap { parts -> [Int]? in
                guard parts.count == 2,
                    let lowerBound = Int(parts[0]),
                    let upperBound = Int(parts[1])
                else { return nil }
                return Array(lowerBound ... upperBound)
            }
            .flatMap(\.self)
            .map(\.digitsOf)

    }

    func isValid(_ n: [Int]) -> Bool {

        guard n.count % 2 == 0 else { return true }

        var leftPtr = 0
        var rightPtr = n.count / 2

        repeat {
            if n[leftPtr] != n[rightPtr] {
                return true
            }
            leftPtr += 1
            rightPtr += 1
        } while rightPtr < n.endIndex

        return false

    }
    func isinValidWithSlidingWindow(_ n: [Int]) -> Bool {
        !isValidWithSlidingWindow(n)
    }

    func isValidWithSlidingWindow(_ n: [Int]) -> Bool {
        guard n.count >= 2 else { return true }

        var windowLength = 1
        let midpoint = n.count / 2
        while windowLength <= midpoint {
            if n.count % windowLength != 0 {
                windowLength += 1
                continue
            }
            var right = windowLength
            let currentSlice = n[0 ..< windowLength]
            var nextSlice = n[right ..< right + windowLength]

            while nextSlice == currentSlice {
                right += windowLength
                if right == n.count {
                    return false
                }
                nextSlice = n[right ..< right + windowLength]
            }
            windowLength += 1
        }
        return true

    }

    func isInvalid(_ n: [Int]) -> Bool {
        !isValid(n)
    }

    public func solvePart1() -> Int {
        numbers
            .filter(isInvalid(_:))
            .map(\.asSingleInt)
            .reduce(0, +)

    }

    public func solvePart2() -> Int {
        numbers
            .filter(isinValidWithSlidingWindow(_:))
            .map(\.asSingleInt)
            .reduce(0, +)
    }
}

extension Int {
    var digitsOf: [Int] {
        var num = abs(self)
        var digits: [Int] = []

        if num == 0 {
            return [0]
        }

        while num > 0 {
            digits.insert(num % 10, at: 0)
            num /= 10
        }

        return digits
    }
}

extension Array where Element == Int {
    var asSingleInt: Int {
        reduce(0) { $0 * 10 + $1 }
    }
}
