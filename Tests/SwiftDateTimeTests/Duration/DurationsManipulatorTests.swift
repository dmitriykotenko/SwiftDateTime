//  Copyright © 2018 Evgeniy Lubaev. All rights reserved.


import XCTest
@testable import SwiftDateTime


class DurationsManipulatorTests: XCTestCase, DurationGenerator {
  
  func testThatSumIsAlwaysValidDuration() {
    for _ in 1..<10000 {
      let a = randomDuration()
      let b = randomDuration()
      
      let summ = a + b
      
      if isInvalidDuration(summ) {
        XCTFail("Invalid duration: \(summ) = \(a) + \(b).")
        break
      }
    }
  }
  
  func testAdditionOfSeconds() {
    for _ in 1..<10000 {
      let a = randomDuration(thousandths: 0)
      let b = randomDuration(thousandths: 0)
      
      let summ = a + b
      
      if summ.seconds != a.seconds + b.seconds || summ.thousandths != 0 {
        XCTFail("Wrong sum: \(summ) = \(a) + \(b).")
        break
      }
    }
  }
  
  func testAdditionOfMilliseconds() {
    for _ in 1..<10000 {
      let a = randomDuration()
      let b = randomDuration()
      
      let summ = a + b
      
      if summ.thousandths != (a.thousandths + b.thousandths) % 1000 {
        XCTFail("Wrong sum: \(summ) = \(a) + \(b).")
        break
      }
    }
  }
  
  func testAssociativity() {
    for _ in 1..<10000 {
      let a = randomDuration()
      let b = randomDuration()
      let c = randomDuration()
      
      let firstSum = (a + b) + c
      let secondSum = a + (b + c)
      
      if firstSum != secondSum {
        XCTFail("Associativity failed:\n" +
          "(\(a) + \(b)) + \(c) = \(firstSum)," +
          "\(a) + (\(b)) + \(c)) = \(secondSum)."
        )
        break
      }
    }
  }

  func testDoubleApplicationOfUnaryMinus() {
    for _ in 1..<10000 {
      let a = randomDuration()
      
      if -(-a) != a {
        XCTFail("a != -(-a): a = \(a), but -(-a) = \(-(-a))")
        break
      }
    }
  }

  func testAntisymmetryOfMinus() {
    for _ in 1..<10000 {
      let a = randomDuration()
      let b = randomDuration()
      
      if a - b != -(b - a) {
        XCTFail("Antisymmetry failed:\n" +
          "\(a) - \(b) = \(a - b)\n" +
          "\(b) - \(a) = \(b - a)\n"
        )
        break
      }
    }
  }

  private func isInvalidDuration(_ duration: Duration) -> Bool {
    duration.seconds < 0
    || duration.thousandths >= 1000
    || duration.thousandths < 0
  }
}
