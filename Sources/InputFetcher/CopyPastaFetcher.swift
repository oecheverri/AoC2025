//  CopyPastaFetcher.swift
//  InputFetcher
//
//  Copyright © 2025 Oscar Echeverri.  All rights reserved.
//

public struct CopyPastaFetcher: InputFetching, Sendable {

    let fetchSampleData: Bool

    public init(
        sampleData: Bool
    ) {
        self.fetchSampleData = sampleData
    }

    public func inputFor(
        day: Int,
        year: Int
    ) async throws -> String {
        let inputs = fetchSampleData ? SampleInputs.inputs : RealInputs.inputs
        guard let yearInputs = inputs[year],
            let input = yearInputs[day]
        else {
            throw InputFetchingError.noInputFound
        }
        return input
    }

}
