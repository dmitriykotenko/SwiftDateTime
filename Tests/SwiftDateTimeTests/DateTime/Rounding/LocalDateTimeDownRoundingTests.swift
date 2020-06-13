//  Copyright © 2018 Evgeniy Lubaev. All rights reserved.


import XCTest
@testable import SwiftDateTime


class LocalDateTimeDownRoundingTests: XCTestCase, DateTimeGenerator, DurationGenerator {
  
  let manipulator = DateTimesManipulator()

  func testRoundingToOneMillisecond() {
    check(
      numberOfTimes: 10000,
      test: { .init(divider: 1.milliseconds, generator: self) },
      condition: { $0.a1 == $0.a2 },
      errorMessage: { "\($0.a1) rounded to \($0.divider) is \($0.a2)" }
    )
  }
  
  func testAbsoluteDifference() {
    check(
      numberOfTimes: 10000,
      test: { .init(generator: self) },
      condition: { abs($0.a1 - $0.a2) < $0.divider },
      errorMessage: { "\($0.a1) rounded to \($0.divider) is \($0.a2)" }
    )
  }
  
  func testDirectionOfRounding() {
    check(
      numberOfTimes: 10000,
      test: { .init(generator: self) },
      condition: { $0.a1 >= $0.a2 },
      errorMessage: { "\($0.a1) rounded to \($0.divider) is \($0.a2)" }
    )
  }
  
  func testRemainder() {
    check(
      numberOfTimes: 10000,
      test: { .init(generator: self) },
      condition: {
        ($0.a1.time.durationFromMidnight + ($0.a2 - $0.a1))
          .positiveRemainder(divider: $0.divider) == .zero
    },
      errorMessage: {
        "Wrong remainder: divider = \($0.divider), " +
          "\($0.a1).durationFromMidnight = \($0.a1.time.durationFromMidnight), " +
        " \($0.a2).durationFromMidnight = \($0.a2remainder)"
    }
    )
  }

  func testIdempotency() {
    check(
      numberOfTimes: 10000,
      test: { .init(generator: self) },
      condition: { $0.a2 == $0.a3 },
      errorMessage: {
        "Idempotency violated: " +
        "\($0.a1) rounded to \($0.divider) = \($0.a2), " +
        "but \($0.a2) rounded to \($0.divider) = \($0.a3)"
      }
    )
  }

  private func check(numberOfTimes: Int,
                     test: () -> Test,
                     condition: (Test) -> Bool,
                     errorMessage: (Test) -> String) {
    _ = (1...numberOfTimes).drop { _ in
      let nextTest = test()
      
      if condition(nextTest) {
        return true
      } else {
        XCTFail(errorMessage(nextTest))
        return false
      }
    }
  }
  
  private struct Test: DateTimeGenerator {
    
    let a1: LocalDateTime
    let divider: Duration
    
    let a2: LocalDateTime
    let a3: LocalDateTime
    
    let a1remainder: Duration
    let a2remainder: Duration
    let a3remainder: Duration
    
    init(divider: Duration? = nil,
         generator: LocalDateTimeDownRoundingTests) {
      self.a1 = generator.randomDivisible()
      self.divider = divider ?? generator.randomDivider()
      
      self.a2 = a1.rounded(downTo: self.divider)
      self.a3 = a2.rounded(downTo: self.divider)
      
      self.a1remainder = a1.positiveRemainder(divider: self.divider)
      self.a2remainder = a2.positiveRemainder(divider: self.divider)
      self.a3remainder = a3.positiveRemainder(divider: self.divider)
    }
  }
  
  func randomDivisible() -> LocalDateTime {
    return randomDateTime().local
  }
  
  func randomDivider() -> Duration {
    return .random(in: 1.milliseconds...Duration.day)
  }
}


private extension LocalDateTime {
  
  func positiveRemainder(divider: Duration) -> Duration {
    return time.durationFromMidnight.positiveRemainder(divider: divider)
  }
}
