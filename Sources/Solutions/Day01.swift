//  Day01.swift
//  Solutions
//
//  Copyright © 2025 Oscar Echeverri.  All rights reserved.
//
import Foundation
import InputFetcher

public struct Day01: Solution {

    let sequence: [Int]
    
    public init (
        day: Int,
        year: Int,
        inputFetcher: some InputFetching,
    ) async throws {
        sequence = try await inputFetcher.input(for: day, in: year)
            .components(separatedBy: .newlines)
            .compactMap {
                guard $0.count > 1,
                      let direction = $0.first,
                      let value = Int($0[$0.index(after: $0.startIndex)..<$0.endIndex])
                else { return nil }
                return direction == "R" ? value : -value
            }
    }

    public func solvePart1() -> Int {
        
        var dial = RotaryDial(
            initialPosition: 50,
            range: 0..<100
        )
        
        var zeroHits = 0
        for offset in sequence {
            dial.turn(by: offset)
            
            if dial.currentPosition == 0 {
                zeroHits += 1
            }
        }

        return zeroHits
    }
    
    public func solvePart2() -> Int {
        var dial = RotaryDial(
            initialPosition: 50,
            range: 0..<100
        )
    
        for offset in sequence {
            dial.turn(by: offset)
        }
        
        return dial.zeroClicks
    }

}

struct RotaryDial {

    var currentPosition: Int
    var zeroClicks = 0
    let range: Range<Int>
    


    init(initialPosition: Int, range: Range<Int>) {
        self.currentPosition = initialPosition
        self.range = range
    }
    
    mutating func turn(by offset: Int) {
        
        guard offset != 0 else { return }

        let (overturns, partialTurn) = offset.quotientAndRemainder(dividingBy: range.count)
        zeroClicks += abs(overturns)
        
        guard partialTurn != 0 else { return }
        
        let initialPosition = currentPosition
        currentPosition += partialTurn
        
        if (!range.contains(currentPosition) && initialPosition != range.lowerBound)
            || currentPosition == range.lowerBound {
            zeroClicks+=1
        }
        
        if currentPosition < range.lowerBound {
            currentPosition = range.upperBound + currentPosition
        } else if currentPosition >= range.upperBound {
            currentPosition = currentPosition - range.upperBound
        }
        
    }

}
