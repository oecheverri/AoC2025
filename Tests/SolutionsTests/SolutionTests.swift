//  Day01Tests.swift
//  SolutionsTests
//
//  Copyright © 2025 Oscar Echeverri.  All rights reserved.
//

import InputFetcher
import Testing

@testable import Solutions

struct SolutionsTests {

    static let fetcher = CopyPastaFetcher(sampleData: true)
    static let realFetcher = CopyPastaFetcher(sampleData: false)

    @Test func `Day 01 - Data Parsing`() async throws {
        let sol = try await makeDay1Solution(with: Self.fetcher)
        #expect(sol.sequence.reduce(0, +) == -218)
    }

    @Test(
        "Day 01 - Part 1",
        arguments: zip(
            [fetcher, realFetcher],
            [3, 1076]
        )
    )
    func testSolutionDay01P1(_ input: any InputFetching, expected: Int) async throws {
        let sol = try await makeDay1Solution(with: input)
        let solution = sol.solvePart1()

        #expect(solution == expected)
    }

    @Test(
        "Day 01 - Part 2",
        arguments: zip(
            [fetcher, realFetcher],
            [6, 6379]
        )
    )
    func testSolutionDay01P2(_ input: any InputFetching, expected: Int) async throws {
        let sol = try await makeDay1Solution(with: input)
        let solution = sol.solvePart2()
        #expect(solution == expected)
    }

}

func makeDay1Solution(with fetcher: some InputFetching) async throws -> Day01 {
    try await Day01(
        input: fetcher.inputFor(day: 1, year: 2025)
    )
}
