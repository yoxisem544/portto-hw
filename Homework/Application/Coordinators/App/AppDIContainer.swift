//
//  AppDIContainer.swift
//  Homework
//
//  Created by David on 2022/4/7.
//

import Foundation

final class AppDIContainer {

    private let networkService: NetworkServiceType

    init() {
        networkService = DefaultNetworkService()
    }

    func makeOpenSeaUseCase() -> OpenSeaUseCaseType {
        OpenSeaUseCase(networkService: networkService)
    }

    func makeETHUseCase() -> ETHUseCaseType {
        ETHUseCase(networkService: networkService)
    }
}
