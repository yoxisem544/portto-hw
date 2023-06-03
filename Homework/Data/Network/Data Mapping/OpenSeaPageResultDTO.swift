//
//  OpenSeaPageResult.swift
//  Homework
//
//  Created by David on 2023/6/3.
//

import Foundation

struct RawOpenSeaPageResult: Decodable {
    let assets: [RawOpenSeaAsset]
    let next: String?

    enum CodingKeys: String, CodingKey {
        case assets = "assets"
        case next = "next"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        assets = try container.decode([RawOpenSeaAsset].self, forKey: .assets)
        next = try? container.decode(String.self, forKey: .next)
    }
}

extension RawOpenSeaPageResult {
    func domainValue() throws -> OpenSeaPageResult {
        let assetDomainValues = try assets.map { try $0.domainValue() }
        return OpenSeaPageResult(assets: assetDomainValues, next: next)
    }
}
