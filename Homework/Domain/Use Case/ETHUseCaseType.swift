//
//  ETHUseCaseType.swift
//  Homework
//
//  Created by David on 2022/4/7.
//

import Foundation
import RxSwift

protocol ETHUseCaseType {
    func fetchETHAmount(of address: String) -> Single<Decimal>
}

struct ETHUseCase: ETHUseCaseType {

    private let networkService: NetworkServiceType

    init(networkService: NetworkServiceType) {
        self.networkService = networkService
    }

    func fetchETHAmount(of address: String) -> Single<Decimal> {
        networkService.request(APIEndpoints.ETH.GetAmount(address: address))
            .map(GetETHAmount.self)
            .map { Decimal($0.eth.balance) }
    }
}
