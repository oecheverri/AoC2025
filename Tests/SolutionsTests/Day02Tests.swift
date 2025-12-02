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
            [99, 101, 22, 251251, 9999, 999999, 999998, 100100, 1010, 5050, 5051],
            [true, false, true, true, true, true, false, true, true, true, false]
        )
    )

    func checksValidityValidly(_ input: Int, _ expected: Bool) {
        let sol = Day02(input: "67-69")

        #expect(sol.isValid(input) == expected)

    }
}
