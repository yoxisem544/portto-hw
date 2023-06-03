//
//  APIEndpoints+OpenSea.swift
//  Homework
//
//  Created by David on 2022/4/7.
//

import Foundation
import Moya

protocol OpenSeaAPIRequestType: NetworkRequestType {}

extension OpenSeaAPIRequestType {
    var baseURL: URL { URL(string: "https://api.opensea.io/api/v1")! }
    var headers: [String: String]? { ["X-API-KEY": "453d9dff05ca4203a79891bfcdccf24e"] }
}

// MARK: - Open Sea

extension APIEndpoints {

    struct OpenSea {

        struct GetAssets: OpenSeaAPIRequestType {
            var path: String { "/assets" }

            var parameters: [String: Any] {
                var dic = [
                    "format": "json",
                    "owner": ownerAddress
                ]

                if let cursor {
                    dic["cursor"] = cursor
                }

                return dic
            }

            private let ownerAddress: String, cursor: String?
            init(ownerAddress: String, cursor: String?) {
                self.ownerAddress = ownerAddress
                self.cursor = cursor
            }
        }
    }
}
