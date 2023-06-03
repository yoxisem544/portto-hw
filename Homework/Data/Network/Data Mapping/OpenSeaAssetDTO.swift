//
//  OpenSeaAssetDTO.swift
//  Homework
//
//  Created by David on 2022/4/6.
//

import Foundation

struct RawOpenSeaAsset: Decodable {
    let permalink: String
    let imageURL: String?
    let collection: Collection
    let id: Int
    let name: String?
    let backgroundColor: String?

    enum CodingKeys: String, CodingKey {
        case permalink = "permalink"
        case imageURL = "image_url"
        case collection = "collection"
        case id = "id"
        case name = "name"
        case backgroundColor = "background_color"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        permalink = try container.decode(String.self, forKey: .permalink)
        imageURL = try? container.decode(String.self, forKey: .imageURL)
        collection = try container.decode(Collection.self, forKey: .collection)
        id = try container.decode(Int.self, forKey: .id)
        name = try? container.decode(String.self, forKey: .name)
        backgroundColor = try? container.decode(String.self, forKey: .backgroundColor)
    }

    struct Collection: Decodable {
        let name: String
        let description: String?

        enum CodingKeys: String, CodingKey {
            case name = "name"
            case description = "description"
        }

        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            name = try container.decode(String.self, forKey: .name)
            description = try? container.decode(String.self, forKey: .description)
        }
    }
}

extension RawOpenSeaAsset {
    func domainValue() throws -> OpenSeaAsset {
        guard let permalink = URL(string: permalink) else { throw DataMappingError.failMapping }

        return OpenSeaAsset(
            permalink: permalink,
            imageURL: imageURL,
            name: name,
            collectionName: collection.name,
            description: collection.description,
            id: id,
            backgroundColorHexString: backgroundColor
        )
    }
}
