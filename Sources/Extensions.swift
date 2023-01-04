/*
 * Reactions
 *
 * Copyright 2016-present Yannick Loriot.
 * http://yannickloriot.com
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 *
 */

import Foundation
import UIKit

extension Sequence where Iterator.Element: Hashable {
  /// Returns uniq elements in the sequence by keeping the order.
  func uniq() -> [Iterator.Element] {
    var alreadySeen: [Iterator.Element: Bool] = [:]

    return filter { alreadySeen.updateValue(true, forKey: $0) == nil }
  }
}

extension Bundle {
  /// Returns the current lib bundle
  class func reactionsBundle() -> Bundle {
    var bundle = Bundle(for: ReactionButton.self)

    if let url = bundle.url(forResource: "Reactions", withExtension: "bundle"), let podBundle = Bundle(url: url) {
      bundle = podBundle
    }

    return bundle
  }
}

extension String {
  /**
   Returns the string localized.
   
   - Parameter tableName: The receiver’s string table to search. By default the method attempts to use the table in FeedbackLocalizable.strings.
   */
  func localized(from tableName: String? = "FeedbackLocalizable") -> String {
    return NSLocalizedString(self, tableName: tableName, bundle: .reactionsBundle(), value: self, comment: "")
  }
}

extension UIColor {
    
    convenience init(rgbColorCodeRed red: Int, green: Int, blue: Int, alpha: CGFloat) {
        let redPart: CGFloat = CGFloat(red) / 255.0
        let greenPart: CGFloat = CGFloat(green) / 255.0
        let bluePart: CGFloat = CGFloat(blue) / 255.0
        self.init(red: redPart, green: greenPart, blue: bluePart, alpha: alpha)
    }
}
