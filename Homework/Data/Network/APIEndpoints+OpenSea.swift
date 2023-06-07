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
    var baseURL: URL { App.env.apiURL }
    var headers: [String: String]? { App.env.openseaAPIHeader }
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
