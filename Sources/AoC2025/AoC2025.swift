// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation
import InputFetcher
import Solutions

@main
struct AoC2025 {

    static var solutions: [Int: [Int: () async throws -> any Solution]] = [:]

    static func main() async throws {

        let (year, day, useSampleData) = try parseYearAndDay()
        try await registerSolutions(using: CopyPastaFetcher(sampleData: useSampleData))
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

        printHeader()
        for solution in builtSolutions {
            runSolution(solution)
            print("-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-")
        }

    }

    static func runSolution(_ solution: any Solution) {

        measuring(name: "\(solution.year)-\(solution.day)-Part 1") {
            return solution.solvePart1()
        }

        measuring(name: "\(solution.year)-\(solution.day)-Part 2") {
            return solution.solvePart2()
        }

        measuring(name: "\(solution.year)-\(solution.day)-Part 1 Opt") {
            return try solution.solvePart1Optimized()
        }

        measuring(name: "\(solution.year)-\(solution.day)-Part 2 Opt") {
            return try solution.solvePart2Optimized()
        }

    }

    static func registerSolutions(using fetcher: any InputFetching) async throws {
        solutions[2025] = [
            1: { try await Day01(input: fetcher.inputFor(day: 1, year: 2025)) },
            2: { try await Day02(input: fetcher.inputFor(day: 2, year: 2025)) },
            3: { try await Day03(input: fetcher.inputFor(day: 3, year: 2025)) },
            4: { try await Day04(input: fetcher.inputFor(day: 4, year: 2025)) },
            5: { try await Day05(input: fetcher.inputFor(day: 5, year: 2025)) },
        ]
    }

    static func measuring<Result>(name: String, work: () throws -> Result) {
        let clock = ContinuousClock()
        let start = clock.now
        let result: Result
        do {
            result = try work()
        } catch {
            return
        }
        let elapsed = start.duration(to: clock.now)
        printResultRow(name: name, elapsed: elapsed, result: result)
    }

    static func printHeader() {
        let part = "Solution".padded(to: ResultTableConfig.partWidth)
        let micro = "Duration (µs)".padded(to: ResultTableConfig.microWidth)
        let seconds = "Duration (s)".padded(to: ResultTableConfig.secondsWidth)
        let result = "Result".padded(to: ResultTableConfig.resultWidth)

        print("\(part) \(micro) \(seconds) \(result)")
        print(
            String(
                repeating: "-",
                count: ResultTableConfig.partWidth
                    + ResultTableConfig.microWidth
                    + ResultTableConfig.secondsWidth
                    + ResultTableConfig.resultWidth
                    + 3))  // spaces between columns
    }

    static func printResultRow<Result>(name: String, elapsed: Duration, result: Result) {
        let col1 = name.padded(to: ResultTableConfig.partWidth)
        let col2 = elapsed.µsString.padded(to: ResultTableConfig.microWidth, alignment: .right)
        let col3 = ("(\(elapsed.sString))").padded(to: ResultTableConfig.secondsWidth, alignment: .right)
        let col4 = "\(result)".padded(to: ResultTableConfig.resultWidth)

        print("\(col1) \(col2) \(col3) \(col4)")
    }

    struct ResultTableConfig {
        static let partWidth = 24
        static let microWidth = 16
        static let secondsWidth = 16
        static let resultWidth = 8
    }

    struct ResultRow {
        let part: String
        let micro: String  // e.g. elapsed.µsString
        let seconds: String  // e.g. elapsed.sString
        let result: String  // "\(result)"
    }

    private static func parseYearAndDay() throws -> (year: Int, day: Int?, useSampleData: Bool) {
        var year: Int?
        var day: Int?
        var useSampleData = false
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
                case "--use-samples":
                    useSampleData = true
                default:
                    print("Unknown argument: \(arg)")
                    throw ExitError.invalidArguments
            }
        }

        return (year ?? 2025, day, useSampleData)
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

    var µsString: String {
        "\(asMicroSeconds.formatted(.number.grouping(.automatic))) µs"
    }

    var asSeconds: Double {
        let comps = components
        return Double(comps.seconds)
            + Double(comps.attoseconds) / 1_000_000_000_000_000_000
    }

    var sString: String {
        "\(asSeconds.formatted(.number.precision(.fractionLength(9)))) s"
    }
}

extension String {
    enum Alignment { case left, right }

    func padded(to width: Int, alignment: Alignment = .left) -> String {
        let count = self.count
        guard count < width else { return self }

        let pad = String(repeating: " ", count: width - count)
        return alignment == .left ? self + pad : pad + self
    }
}
