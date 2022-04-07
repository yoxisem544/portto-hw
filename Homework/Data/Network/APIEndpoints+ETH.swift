//
//  APIEndpoints+ETH.swift
//  Homework
//
//  Created by David on 2022/4/7.
//

import Foundation

protocol ETHAPIRequestType: NetworkRequestType {}

extension ETHAPIRequestType {
    var baseURL: URL { URL(string: "https://api.ethplorer.io")! }
}

extension APIEndpoints {

    struct ETH {

        struct GetAmount: ETHAPIRequestType {
            var path: String { "/getAddressInfo/\(address)" }

            var parameters: [String: Any] {
                ["apiKey": "freeKey"]
            }

            private let address: String
            init(address: String) {
                self.address = address
            }
        }
    }
}
