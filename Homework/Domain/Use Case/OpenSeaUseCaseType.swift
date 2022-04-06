//
//  OpenSeaUseCaseType.swift
//  Homework
//
//  Created by David on 2022/4/6.
//

import Foundation
import RxSwift

protocol OpenSeaUseCaseType {

    /// Fetch open sea assets.
    /// - Parameters:
    ///   - owner: should be a ethereum address
    ///   - offset: start index
    /// - Returns: An array of OpenSeaAsset
    func fetchAssets(of owner: String, offset: Int) -> Single<[OpenSeaAsset]>
}

struct OpenSeaUseCase: OpenSeaUseCaseType {

    private let networkService: NetworkServiceType

    init() {
        networkService = DefaultNetworkService()
    }

    func fetchAssets(of owner: String, offset: Int) -> Single<[OpenSeaAsset]> {
        networkService.request(APIEndpoints.OpenSea.GetAssets(ownerAddress: owner, offset: offset))
            .map([RawOpenSeaAsset].self, atKeyPath: "assets")
            .map { try $0.map { try $0.domainValue() } }
    }
}
