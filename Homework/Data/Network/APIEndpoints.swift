//
//  APIEndpoints.swift
//  Homework
//
//  Created by David on 2022/4/6.
//

import Foundation
import Moya

protocol OpenSeaAPIRequestType: NetworkRequestType {}

extension OpenSeaAPIRequestType {
    var baseURL: URL { URL(string: "https://api.opensea.io/api/v1")! }
    var headers: [String: String]? { ["X-API-KEY": "5b294e9193d240e39eefc5e6e551ce83"] }
}

// MARK: - Namespace
struct APIEndpoints {}

// MARK: - Open Sea

extension APIEndpoints {

    struct OpenSea {

        struct GetAssets: OpenSeaAPIRequestType {
            var path: String { "/assets" }

            var parameters: [String: Any] {
                [
                    "format": "json",
                    "owner": ownerAddress,
                    "offset": offset,
                    "limit": limit
                ]
            }

            private let ownerAddress: String, offset: Int, limit: Int
            init(ownerAddress: String, offset: Int = 0, limit: Int = 20) {
                self.ownerAddress = ownerAddress
                self.offset = offset
                self.limit = limit
            }
        }
    }
}
