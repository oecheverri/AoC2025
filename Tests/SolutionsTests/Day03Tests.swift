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
            ([7,8,9], 89)
        ]
    )

    func tabulatesMaxValue(input: [Int], expected: Int) {
        let sol = Day03(input: "")
        #expect(sol.findMaxValue(in: input) == expected)
    }

}
