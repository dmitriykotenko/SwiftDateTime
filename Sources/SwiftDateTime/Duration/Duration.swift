//  Copyright © 2018 Evgeniy Lubaev. All rights reserved.


public struct Duration: Codable, Equatable, Hashable {
  
  static let zero = Duration(milliseconds: 0)
  
  static let day = Duration(milliseconds: .millisecondsPerDay)

  var milliseconds: Int64
  
  var signum: Int {
    return Int(milliseconds.signum())
  }
  
  var seconds: Int { return Int(abs(milliseconds)) / 1000 }
  var thousandths: Int { return Int(abs(milliseconds)) % 1000 }
  
  init(milliseconds: Int64) {
    self.milliseconds = milliseconds
  }
  
  init(milliseconds: Int) {
    self.init(milliseconds: Int64(milliseconds))
  }
  
  init(negative: Bool = false,
       seconds: Int,
       thousandths: Int = 0) {
    let signum = negative ? -1 : 1
    
    self.milliseconds = Int64(signum * seconds * 1000 + signum * thousandths)
  }
  
  init(negative: Bool = false,
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
