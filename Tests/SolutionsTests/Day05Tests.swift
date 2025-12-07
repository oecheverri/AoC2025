//
//  Day05Tests.swift
//  AoC2025
//
//  Created by Oscar Echeverri on 2025-12-06.
//

import InputFetcher
import Testing

@testable import Solutions

struct Day05Tests {

    @Test
    func testPart1() async throws {

        let solution = try #require(try? await Day05(input: CopyPastaFetcher(sampleData: true).inputFor(day: 5, year: 2025)))

        #expect(solution.solvePart1() == 3)

    }

    @Test
    func testPart2() async throws {
        let solution = try #require(try? await Day05(input: CopyPastaFetcher(sampleData: true).inputFor(day: 5, year: 2025)))

        #expect(solution.solvePart2() == 14)
    }

    @Test
    func mergesRangesProperly() async throws {
        let solution = try #require(try? await Day05(input: CopyPastaFetcher(sampleData: true).inputFor(day: 5, year: 2025)))

        let ranges = [
            1 ... 6,
            5 ... 6,
            2 ... 7,
            9 ... 12,
        ]

        let merged = solution.mergeOverlappingRanges(ranges)

        #expect(merged == [1 ... 7, 9 ... 12])
    }

}
