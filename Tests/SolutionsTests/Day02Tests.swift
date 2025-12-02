import InputFetcher
//
//  Day02Tests.swift
//  AoC2025
//
//  Created by Oscar Echeverri on 2025-12-02.
//
import Testing

@testable import Solutions

struct Day02Tests {

    @Test(
        "Tests whether or not our algorithm for checking validity works",
        arguments: zip(
            [99, 101, 22, 251251, 9999, 999999, 999998, 100100, 1010, 5050, 5051, 999],
            [false, true, false, false, false, false, true, false, false, false, true, true]
        )
    )

    func checksValidityValidly(_ input: Int, _ expected: Bool) {
        let sol = Day02(input: "67-69")
        #expect(sol.isValid(input.digitsOf) == expected)

    }

    @Test(
        "Tests whether sliding window parirings works",
        arguments: zip(
            [
                [1, 2, 1, 2, 1],
                [1],
                [1, 2, 1, 2],
                [1, 1],
                [1, 1, 1],
                [1, 2, 3, 4, 1, 2, 3, 4],
            ],
            [
                true,
                true,
                false,
                false,
                false,
                false,
            ]
        )
    )
    func checksValidityWithSlidingWindow(_ input: [Int], _ expected: Bool) {
        let sol = Day02(input: "67-69")
        #expect(sol.isValidWithSlidingWindow(input) == expected)
    }

    @Test func `Test Part 1 Solution`() async throws {
        let sampleFetcher = CopyPastaFetcher(sampleData: true)
        let realFetcher = CopyPastaFetcher(sampleData: false)

        let solSample = try await Day02(
            input: sampleFetcher.inputFor(day: 2, year: 2025)
        )

        let solReal = try await Day02(
            input: realFetcher.inputFor(day: 2, year: 2025)
        )

        #expect(solSample.solvePart1() == 1_227_775_554)
        #expect(solReal.solvePart1() == 31_000_881_061)
    }

    @Test func `Test Part 2 Solution`() async throws {
        let sampleFetcher = CopyPastaFetcher(sampleData: true)
        let realFetcher = CopyPastaFetcher(sampleData: false)

        let solSample = try await Day02(
            input: sampleFetcher.inputFor(day: 2, year: 2025)
        )

        let solReal = try await Day02(
            input: realFetcher.inputFor(day: 2, year: 2025)
        )

        #expect(solSample.solvePart2() == 4_174_379_265)
        #expect(solReal.solvePart2() == 46_769_308_485)
    }
}
