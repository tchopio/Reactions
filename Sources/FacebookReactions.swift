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

import UIKit

/// Default implementation of the facebook reactions.
extension Reaction {
  /// Struct which defines the standard facebook reactions.
  public struct facebook {
    
    /// Default for unselected "like" button, ignored in .all
    public static var likeTemplate: Reaction {
        return reactionWithId("like-template")
    }
    
    /// The facebook's "like" reaction.
    public static var like: Reaction {
      return reactionWithId("like")
    }

    /// The facebook's "love" reaction.
    public static var love: Reaction {
      return reactionWithId("love")
    }

    /// The facebook's "haha" reaction.
    public static var haha: Reaction {
      return reactionWithId("haha")
    }

    /// The facebook's "wow" reaction.
    public static var wow: Reaction {
      return reactionWithId("wow")
    }

    /// The facebook's "sad" reaction.
    public static var sad: Reaction {
      return reactionWithId("sad")
    }

    /// The facebook's "angry" reaction.
    public static var angry: Reaction {
      return reactionWithId("angry")
    }
      
    /// Set color for empty reaction
    public static var emptyColor: UIColor = .black
    /// Set color for default reaction
    public static var defColor: UIColor = UIColor(red: 0.99, green: 0.84, blue: 0.38, alpha: 1)
    /// Set color for like reaction
    public static var likeColor: UIColor = UIColor(red: 0.29, green: 0.54, blue: 0.95, alpha: 1)
    /// Set color for love reaction
    public static var loveColor: UIColor = UIColor(red: 0.93, green: 0.23, blue: 0.33, alpha: 1)
    /// Set color for angry reaction
    public static var angryColor: UIColor = UIColor(red: 0.96, green: 0.37, blue: 0.34, alpha: 1)

    /// The list of standard facebook reactions in this order: `.like`, `.love`, `.haha`, `.wow`, `.sad`, `.angry`.
    public static let all: [Reaction] = [facebook.like, facebook.love, facebook.haha, facebook.wow, facebook.sad, facebook.angry]

    // MARK: - Convenience Methods

    private static func reactionWithId(_ id: String) -> Reaction {
        var color: UIColor            = .black
        var icon: UIImage = imageWithName(id)
        
        color = k_kinkyMagentaColor
        switch id {
        case "like-template":
            //color = .black
            if #available(iOS 13.0, *) {
                icon = icon.withTintColor(color)
            }
//        case "like":
//            //color = UIColor(red: 0.29, green: 0.54, blue: 0.95, alpha: 1)
//            color = UIColor(red: 255/255, green: 241/255, blue: 51/255, alpha: 1)
//        case "love":
//            //color = UIColor(red: 0.93, green: 0.23, blue: 0.33, alpha: 1)
//            color = UIColor(red: 145/255, green: 245/255, blue: 74/255, alpha: 1)
//        case "angry":
//            color = UIColor(red: 0.96, green: 0.37, blue: 0.34, alpha: 1)
        default:
            color = k_kinkyMagentaColor //UIColor(red: 0.99, green: 0.84, blue: 0.38, alpha: 1)
        }
        
        return Reaction(id: id, title: id.localized(from: "FacebookReactionLocalizable"), color: color, icon: icon, alternativeIcon: icon)
    }
      
      private static func imageWithName(_ name: String) -> UIImage {
          if let cached = _imageWithNameCache[name] {
              return cached
          }
          
          let insets = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4) // Original images did not have outter spacing
          let image = UIImage(named: name, in: .reactionsBundle(), compatibleWith: nil)!._reactions_imageWithInsets(insets: insets)!
          _imageWithNameCache[name] = image
          return image
      }
      
      /// Cache loaded images
      private static var _imageWithNameCache = [String: UIImage]()
      
  }
}

private extension UIImage {
    func _reactions_imageWithInsets(insets: UIEdgeInsets) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(
            CGSize(width: self.size.width + insets.left + insets.right,
                   height: self.size.height + insets.top + insets.bottom), false, self.scale)
        let _ = UIGraphicsGetCurrentContext()
        let origin = CGPoint(x: insets.left, y: insets.top)
        self.draw(at: origin)
        let imageWithInsets = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return imageWithInsets
    }
}
