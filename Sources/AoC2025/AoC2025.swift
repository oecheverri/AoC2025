// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation
import InputFetcher
import Solutions

@main
struct AoC2025 {
    static func main() async throws {

        let fetcher = CopyPastaFetcher(sampleData: false)
        let day1 = try await Day01(day: 1, year: 2025, inputFetcher: fetcher)

        measuring(name: "Day01 - Part 1") { name in
            let result = day1.solvePart1()
            print("Result for \(name): \(result)")
        }

        measuring(name: "Day01 - Part 2") { name in
            let result = day1.solvePart2()
            print("Result for \(name): \(result)")
        }

    }

    static func measuring(name: String, work: (String) -> Void) {
        let clock = ContinuousClock()
        let start = clock.now
        work(name)
        let elapsed = start.duration(to: clock.now)

        print("\(name) took \(elapsed.asMicroSeconds)µs")
    }
}

extension Duration {
    var asMicroSeconds: Int {
        let sec = components.seconds
        let attos = components.attoseconds

        return Int(sec * 1_000_000 + attos / 1_000_000_000_000)
    }
}
