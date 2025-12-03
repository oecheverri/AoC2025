//
//  Solution.swift
//  AoC2025
//
//  Created by Oscar Echeverri on 2025-12-02.
//
import InputFetcher

public protocol Solution: Sendable {

    associatedtype Result

    var year: Int { get }
    var day: Int { get }

    init(input: String)

    func solvePart1() -> Result
    func solvePart2() -> Result

    func solvePart1Optimized() throws -> Result
    func solvePart2Optimized() throws -> Result

}

extension Solution {

    public func solvePart1Optimized() throws -> Result {
        throw SolutionError.notImplemented(#function)
    }

    public func solvePart2Optimized() throws -> Result {
        throw SolutionError.notImplemented(#function)
    }

}

enum SolutionError: Error {
    case notImplemented(String)
}
