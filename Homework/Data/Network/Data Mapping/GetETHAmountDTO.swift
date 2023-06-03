//
//  GetETHAmountDTO.swift
//  Homework
//
//  Created by David on 2022/4/7.
//

import Foundation

struct GetETHAmount: Decodable {
    let balance: String

    enum CodingKeys: String, CodingKey {
        case balance = "result"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        balance = try container.decode(String.self, forKey: .balance)
    }
}
