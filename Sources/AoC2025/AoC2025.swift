// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation
import InputFetcher
import Solutions

@main
struct AoC2025 {

    static var solutions: [Int: [Int: () async throws -> any Solution]] = [:]
    static let fetcher: some InputFetching = CopyPastaFetcher(sampleData: false)

    static func main() async throws {

        try await registerSolutions()
        let (year, day) = try parseYearAndDay()

        guard let yearSolutions = solutions[year] else {
            throw ExitError.noSolutionsFound
        }

        let solutionDays = day.map { [$0] } ?? yearSolutions.keys.sorted()

        var builtSolutions: [any Solution] = []

        for day in solutionDays {
            guard let factory = yearSolutions[day] else {
                print("No solution found for: \(year)-\(day)")
                throw ExitError.noSolutionsFound
            }

            let solution = try await factory()
            builtSolutions.append(solution)
        }

        for solution in builtSolutions {
            runSolution(solution)
        }

    }

    static func runSolution(_ solution: any Solution) {

        measuring(name: "\(solution.year)-\(solution.day)-Part 1") {
            return solution.solvePart1()
        }

        measuring(name: "\(solution.year)-\(solution.day)-Part 2") {
            return solution.solvePart2()
        }

    }

    static func registerSolutions() async throws {
        solutions[2025] = [
            1: { try await Day01(input: fetcher.inputFor(day: 1, year: 2025)) }
        ]
    }

    static func measuring<Result>(name: String, work: () -> Result) {
        let clock = ContinuousClock()
        let start = clock.now
        let result = work()
        let elapsed = start.duration(to: clock.now)
        print("\(name) took \(elapsed.asMicroSeconds)µs - Result: \(result)")
    }

    private static func parseYearAndDay() throws -> (year: Int, day: Int?) {
        var year: Int?
        var day: Int?

        var iterator = CommandLine.arguments.dropFirst().makeIterator()
        while let arg = iterator.next() {
            switch arg {
                case "--year", "-y":
                    guard let value = iterator.next(), let int = Int(value) else {
                        print("Missing or invalid value for \(arg)")
                        throw ExitError.invalidArguments
                    }
                    year = int

                case "--day", "-d":
                    guard let value = iterator.next(), let int = Int(value) else {
                        print("Missing or invalid value for \(arg)")
                        throw ExitError.invalidArguments
                    }
                    day = int

                case "--help", "-h":
                    print(
                        """
                        Usage:
                          advent --year <yyyy> --day <dd>

                        Example:
                          advent --year 2025 --day 1
                        """)
                    throw ExitError.invalidArguments

                default:
                    print("Unknown argument: \(arg)")
                    throw ExitError.invalidArguments
            }
        }

        return (year ?? 2025, day)
    }

}

enum ExitError: Error {
    case invalidArguments
    case noSolutionsFound
}

extension Duration {
    var asMicroSeconds: Int {
        let sec = components.seconds
        let attos = components.attoseconds

        return Int(sec * 1_000_000 + attos / 1_000_000_000_000)
    }
}
