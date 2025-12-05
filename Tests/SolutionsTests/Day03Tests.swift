//
//  Day03Tests.swift
//  AoC2025
//
//  Created by Oscar Echeverri on 2025-12-03.
//

import Testing

@testable import Solutions

struct Day03Tests {

    @Test(
        "Tabulation Test",
        arguments: [
            ([9, 8, 7, 6, 5, 4, 3, 2, 1, 1, 1, 1, 1, 1, 1], 98),
            ([8, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 9], 89),
            ([2, 3, 4, 2, 3, 4, 2, 3, 4, 2, 3, 4, 2, 7, 8], 78),
            ([8, 1, 8, 1, 8, 1, 9, 1, 1, 1, 1, 2, 1, 1, 1], 92),
        ]
    )

    func tabulatesMaxValue(input: [Int], expected: Int) {
        let sol = Day03(input: "")
        #expect(sol.findMaxValue(in: input) == expected)
    }

    @Test(
        "Tabulation Sequence Test",
        arguments: [
            ([9, 8, 7, 6, 5, 4, 3, 2, 1, 1, 1, 1, 1, 1, 1], 987_654_321_111),
            ([8, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 9], 811_111_111_119),
            ([2, 3, 4, 2, 3, 4, 2, 3, 4, 2, 3, 4, 2, 7, 8], 434_234_234_278),
            ([8, 1, 8, 1, 8, 1, 9, 1, 1, 1, 1, 2, 1, 1, 1], 888_911_112_111),
        ]
    )
    func tabulateMaxSequence(input: [Int], expected: Int) {
        let sol = Day03(input: "")
        let result = sol.findNLargestDigits(in: input, n: 12).asSingleInt
        #expect(result == expected)
    }

}
