//  Copyright © 2020 Evgeniy Lubaev. All rights reserved.


import Foundation


extension Array {

  func chunks(length: Int) -> [[Element]] {
    stride(from: 0, to: count, by: length)
      .map { Array(dropFirst($0).prefix(length)) }
  }
}
