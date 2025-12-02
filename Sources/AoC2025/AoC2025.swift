// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation
import Solutions

@main
struct AoC2025 {
    static func main() {
        
        let day1p1 = Day01(input: day01Input)
        measuring(name: "Day01 - Part 1") { name in
            let result = day1p1.solvePart1()
            print("Result for \(name): \(result)")
        }
        
        let day1p2 = Day01(input: day01Input)
        measuring(name: "Day01 - Part 2") { name in
            let result = day1p2.solvePart2()
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
