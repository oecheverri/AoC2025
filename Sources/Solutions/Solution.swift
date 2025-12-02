//
//  Solution.swift
//  AoC2025
//
//  Created by Oscar Echeverri on 2025-12-02.
//
import InputFetcher

public protocol Solution: Sendable {

    associatedtype Result

    init(
        day: Int,
        year: Int,
        inputFetcher: some InputFetching
    ) async throws

    func solvePart1() -> Result
    func solvePart2() -> Result

}
