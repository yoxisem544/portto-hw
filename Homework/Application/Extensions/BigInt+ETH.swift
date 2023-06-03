//
//  BigInt+ETH.swift
//  Homework
//
//  Created by David on 2023/6/3.
//

import Foundation
import BigInt

extension BigUInt {

    var ethDecimalValue: Decimal? {
        let str = String(self, radix: 10)
        guard var number = Decimal(string: str) else { return nil }

        number /= pow(10, 18) // ETH decimals, can be refactor if we support a lot coins in future
        return number
    }
}
