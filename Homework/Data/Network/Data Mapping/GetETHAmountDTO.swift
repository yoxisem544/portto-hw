//
//  GetETHAmountDTO.swift
//  Homework
//
//  Created by David on 2022/4/7.
//

import Foundation

struct GetETHAmount: Decodable {
    let eth: ETH

    enum CodingKeys: String, CodingKey {
        case eth = "ETH"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        eth = try container.decode(ETH.self, forKey: .eth)
    }

    struct ETH: Decodable {
        let balance: Double

        enum CodingKeys: String, CodingKey {
            case balance = "balance"
        }

        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            balance = try container.decode(Double.self, forKey: .balance)
        }
    }
}
