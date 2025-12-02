//
//  RotaryDialTests.swift
//  AoC2025
//
//  Created by Oscar Echeverri on 2025-12-02.
//

import Testing
@testable import Solutions

struct RotaryDialTests {
    
    
    @Test
    func `The Dial Works`() {
        
        var dial = RotaryDial(
            initialPosition: 5,
            range: 0..<10
        )
        
        #expect(dial.currentPosition == 5)
        
        dial.turn(by: -5)
        #expect(dial.currentPosition == 0)
        
        dial.turn(by: -3)
        #expect(dial.currentPosition == 7)
        
        dial.turn(by: 3)
        #expect(dial.currentPosition == 0)
        
        dial.turn(by: 9)
        #expect(dial.currentPosition == 9)
        
        dial.turn(by: -100)
        #expect(dial.currentPosition == 9)
        
        dial.turn(by: 101)
        #expect(dial.currentPosition == 0)
        
        
    }
    
    @Test
    func landingOnZeroCounts() {
        var dial = RotaryDial(
            initialPosition: 1,
            range: 0..<10
        )
        
        dial.turn(by: -1)
        #expect(dial.zeroClicks == 1)
        #expect(dial.currentPosition == 0)
        
        dial.turn(by: 11)
        #expect(dial.zeroClicks == 2)
        #expect(dial.currentPosition == 1)
        
        dial.turn(by: -1)
        #expect(dial.zeroClicks == 3)
        #expect(dial.currentPosition == 0)
        
        dial.turn(by: 20)
        #expect(dial.zeroClicks == 5)
        #expect(dial.currentPosition == 0)
        
        dial.turn(by: 5)
        #expect(dial.zeroClicks == 5)
        #expect(dial.currentPosition == 5)
        
        dial.turn(by: 10)
        #expect(dial.zeroClicks == 6)
        #expect(dial.currentPosition == 5)
        
        dial.turn(by: -10)
        #expect(dial.zeroClicks == 7)
        #expect(dial.currentPosition == 5)
        
        dial.turn(by: -101)
        #expect(dial.zeroClicks == 17)
        #expect(dial.currentPosition == 4)
        
    }
    
    @Test
    func countingZeroesWorks() {
        var dial = RotaryDial(
            initialPosition: 5,
            range: 0..<10
        )
        
        dial.turn(by: 100)
        #expect(dial.zeroClicks == 10)
        #expect(dial.currentPosition == 5)
        
        dial.turn(by: -100)
        #expect(dial.zeroClicks == 20)
        #expect(dial.currentPosition == 5)
        
        dial.turn(by: -125)
        #expect(dial.zeroClicks == 33)
        #expect(dial.currentPosition == 0)
        
        dial.turn(by: -1)
        #expect(dial.zeroClicks == 33)
        #expect(dial.currentPosition == 9)
        
        dial.turn(by: 31)
        #expect(dial.zeroClicks == 37)
        #expect(dial.currentPosition == 0)
        
        dial.turn(by: 20)
        #expect(dial.zeroClicks == 39)
        #expect(dial.currentPosition == 0)
    }
    
    @Test
    func touchedNeverDecrements() {
        
        var dial = RotaryDial(
            initialPosition: 5,
            range: 0..<10
        )
        
        var lastzeroClicks = dial.zeroClicks
        for _ in 0..<10000 {
            dial.turn(
                by: Int.random(in: -10_000_000...10_000_000)
            )
            #expect(dial.zeroClicks >= lastzeroClicks)
            lastzeroClicks = dial.zeroClicks
        }
    }
    
    
}
