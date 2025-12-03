//
//  AdventOfCodeDataRequest.swift
//  AoC2025
//
//  Created by Oscar Echeverri on 2025-12-02.
//
import Foundation

struct AdventOfCodeDataFetcher: InputFetching {

    let session: URLSession = .init(configuration: .default)

    let urlPath = "https://adventofcode.com/%d/day/%d"

    init(sampleData: Bool) {
    }

    func inputFor(day: Int, year: Int) async throws -> String {
        try await fetchInputFor(year: year, day: day)
    }

    private func fetchInputFor(year: Int, day: Int) async throws -> String {
        guard let cookie = ProcessInfo.processInfo.environment["AOCCOOKIE"],
            let url = URL(string: .init(format: urlPath, year, day))
        else {
            throw InputFetchingError.errorFetchingInput
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.setValue(cookie, forHTTPHeaderField: "session")
        let (data, _) = try await session.data(for: urlRequest)

        guard let string = String(data: data, encoding: .utf8) else {
            throw InputFetchingError.errorFetchingInput
        }

        return string
    }

}
