//  Copyright © 2018 Evgeniy Lubaev. All rights reserved.


public struct Duration: Codable, Equatable, Hashable {
  
  public static let zero = Duration(milliseconds: 0)
  
  public static let day = Duration(milliseconds: .millisecondsPerDay)
  
  public var milliseconds: Int64
  
  public var signum: Int {
    return Int(milliseconds.signum())
  }
  
  public var seconds: Int { return Int(abs(milliseconds)) / 1000 }
  public var thousandths: Int { return Int(abs(milliseconds)) % 1000 }
  
  public init(milliseconds: Int64) {
    self.milliseconds = milliseconds
  }
  
  public init(milliseconds: Int) {
    self.init(milliseconds: Int64(milliseconds))
  }
  
  public init(negative: Bool = false,
              seconds: Int,
              thousandths: Int = 0) {
    let signum = negative ? -1 : 1
    
    self.milliseconds = Int64(signum * seconds * 1000 + signum * thousandths)
  }
  
  public init(negative: Bool = false,
              hours: Int = 0,
              minutes: Int = 0,
              seconds: Int = 0,
              thousandths: Int = 0) {
    self.init(
      negative: negative,
      seconds: hours * 3600 + minutes * 60 + seconds,
      thousandths: thousandths
    )
  }
}


extension Duration: Comparable {
  
  public static func < (this: Duration, that: Duration) -> Bool {
    return this.milliseconds < that.milliseconds
  }
}
