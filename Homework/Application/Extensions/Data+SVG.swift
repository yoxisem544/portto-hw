//
//  Data+SVG.swift
//  Homework
//
//  Created by David on 2023/6/3.
//

import Foundation

extension Data {
    var isSVG: Bool {
        guard let testString = String(data: self, encoding: .utf8) else {
            return false
        }

        if testString.hasPrefix("<svg"), testString.hasSuffix("</svg>") {
            return true
        } else {
            return false
        }
    }
}
