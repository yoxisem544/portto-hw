//
//  CoordinatorType.swift
//  Homework
//
//  Created by David on 2022/4/7.
//

import Foundation

protocol CoordinatorType: AnyObject {
    var children: [CoordinatorType] { get set }
}
