//
//  String+HexColor.swift
//  Homework
//
//  Created by David on 2023/6/3.
//

import UIKit

extension String {

    var hexColor: UIColor? {
        UIColor(hexString: self)
    }
}
