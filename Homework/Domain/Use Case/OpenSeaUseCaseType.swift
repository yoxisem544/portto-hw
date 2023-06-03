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
    func fetchAssets(of owner: String, cursor: String?) -> Single<OpenSeaPageResult>
}

struct OpenSeaUseCase: OpenSeaUseCaseType {

    private let networkService: NetworkServiceType

    init(networkService: NetworkServiceType) {
        self.networkService = networkService
    }

    func fetchAssets(of owner: String, cursor: String?) -> Single<OpenSeaPageResult> {
        networkService.request(APIEndpoints.OpenSea.GetAssets(ownerAddress: owner, cursor: cursor))
            .map(RawOpenSeaPageResult.self)
            .map { try $0.domainValue() }
    }
}
