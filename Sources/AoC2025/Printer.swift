//  Printer.swift
//  AoC2025
//
//  Copyright © 2025 Oscar Echeverri.  All rights reserved.
//

func printHeader() {
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

func printResultRow<Result>(name: String, elapsed: Duration, result: Result) {
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
