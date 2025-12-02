//  InputFetching.swift
//  InputFetcher
//
//  Copyright © 2025 Oscar Echeverri.  All rights reserved.
//

enum InputFetchingError: Error {
    case noInputFound
    case errorFetchingInput
    case samplesNotSupported
}

public protocol InputFetching: Sendable {

    init(sampleData: Bool)

    func inputFor(
        day: Int,
        year: Int
    ) async throws -> String
}
