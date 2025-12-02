//  InputFetching.swift
//  InputFetcher
//
//  Copyright © 2025 Oscar Echeverri.  All rights reserved.
//

public protocol InputFetching {
    func input(for problem: Int, in year: Int) async throws -> String
}
