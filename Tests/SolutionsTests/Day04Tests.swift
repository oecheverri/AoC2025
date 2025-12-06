import InputFetcher
//
//  Day04Tests.swift
//  AoC2025
//
//  Created by Oscar Echeverri on 2025-12-05.
//
import Testing

@testable import Solutions

struct Day04Tests {
    @Test
    func testSolutionForPart1() async throws {
        let sol = try #require(try? await Day04(input: CopyPastaFetcher(sampleData: true).inputFor(day: 4, year: 2025)))

        #expect(sol.solvePart1() == 13)
    }

    @Test
    func testSolutionForPart2() async throws {
        let sol = try #require(try? await Day04(input: CopyPastaFetcher(sampleData: true).inputFor(day: 4, year: 2025)))

        #expect(sol.solvePart2() == 43)
    }
}
