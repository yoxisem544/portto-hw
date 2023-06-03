//
//  ETHUseCaseType.swift
//  Homework
//
//  Created by David on 2022/4/7.
//

import Foundation
import RxSwift
import BigInt

protocol ETHUseCaseType {
    func fetchETHAmount(of address: String) -> Single<BigUInt?>
}

struct ETHUseCase: ETHUseCaseType {

    private let networkService: NetworkServiceType

    init(networkService: NetworkServiceType) {
        self.networkService = networkService
    }

    func fetchETHAmount(of address: String) -> Single<BigUInt?> {
        networkService.request(APIEndpoints.ETH.GetAmount(address: address))
            .map(GetETHAmount.self)
            .map {
                if $0.balance.hasPrefix("0x") {
                    return String($0.balance.dropFirst(2))
                } else {
                    return $0.balance
                }
            }
            .map { BigUInt($0, radix: 16) }
    }
}
