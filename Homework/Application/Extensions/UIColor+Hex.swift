//
//  UIColor+Hex.swift
//  Homework
//
//  Created by David on 2023/6/3.
//

import UIKit

extension UIColor {

    /// Init a UIColor with given string
    ///
    /// - Like #aabbcc will get a rgb color with alpha at 1.
    /// - Like #aabbcc00 will get a rgb color with alpha at 0.
    ///
    /// Only rgb or rgba color string is supported.
    public convenience init?(hexString: String) {
        let hexString = hexString.replacingOccurrences(of: "#", with: "")

        switch hexString.count {
        case 6:
            guard let hex = UInt(hexString, radix: 16) else { return nil }
            let red = (hex & 0xFF0000) >> 16
            let green = (hex & 0x00FF00) >> 8
            let blue = (hex & 0x0000FF)
            self.init(red: CGFloat(red) / 0xFF, green: CGFloat(green) / 0xFF, blue: CGFloat(blue) / 0xFF, alpha: 1)

        case 8:
            guard let hex = UInt(hexString, radix: 16) else { return nil }
            let red = (hex & 0xFF000000) >> 24
            let green = (hex & 0x00FF0000) >> 16
            let blue = (hex & 0x0000FF00) >> 8
            let alpha = (hex & 0x000000FF)
            self.init(red: CGFloat(red) / 0xFF, green: CGFloat(green) / 0xFF, blue: CGFloat(blue) / 0xFF, alpha: CGFloat(alpha) / 0xFF)

        default:
            return nil
        }
    }

    convenience init(hex: UInt, alpha: CGFloat = 1.0) {
        let red = (hex & 0xFF0000) >> 16
        let green = (hex & 0x00FF00) >> 8
        let blue = (hex & 0x0000FF)

        self.init(
            red: CGFloat(red) / 0xFF,
            green: CGFloat(green) / 0xFF,
            blue: CGFloat(blue) / 0xFF,
            alpha: alpha
        )
    }
}
