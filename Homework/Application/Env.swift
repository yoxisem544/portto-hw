//
//  Env.swift
//  Homework
//
//  Created by David on 2023/6/6.
//

import Foundation

struct Env {

    static let production = Env(
        apiURL: URL(string: "https://api.opensea.io/api/v1")!,
        apiKey: "453d9dff05ca4203a79891bfcdccf24e",
        ethRPCNodeURL: URL(string: "https://rpc.ankr.com/eth")!,
        address: "0x19818f44faf5a217f619aff0fd487cb2a55cca65"
    )

    static let testnet = Env(
        apiURL: URL(string: "https://testnets-api.opensea.io/api/v1")!,
        apiKey: nil, // test net does not have api key
        ethRPCNodeURL: URL(string: "https://goerli.blockpi.network/v1/rpc/public")!,
        address: "0x85fD692D2a075908079261F5E351e7fE0267dB02"
    )

    let apiURL: URL
    let apiKey: String?
    let ethRPCNodeURL: URL
    let address: String

    var openseaAPIHeader: [String: String]? {
        if let apiKey {
            return ["X-API-KEY": apiKey]
        } else {
            return nil
        }
    }
}
