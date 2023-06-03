//
//  APIEndpoints+ETH.swift
//  Homework
//
//  Created by David on 2022/4/7.
//

import Foundation
import Moya

protocol ETHAPIRequestType: NetworkRequestType {}

extension ETHAPIRequestType {
    var baseURL: URL { URL(string: "https://rpc.ankr.com/eth")! }
}

extension APIEndpoints {

    struct ETH {

        struct GetAmount: ETHAPIRequestType {
            var path: String { "" }
            var method: Moya.Method { .post }

            var parameters: [String: Any] {
                [
                    "jsonrpc": "2.0",
                    "method": "eth_getBalance",
                    "params": [
                        address,
                        "latest"
                    ],
                    "id": 0
                ]
            }

            private let address: String
            init(address: String) {
                self.address = address
            }
        }
    }
}
