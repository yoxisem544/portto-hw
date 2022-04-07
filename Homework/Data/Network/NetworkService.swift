//
//  NetworkService.swift
//  Homework
//
//  Created by David on 2022/4/6.
//

import Foundation
import Moya
import RxSwift

protocol NetworkServiceType {
    func request<R: NetworkRequestType>(_ request: R) -> Single<Response>
}

final class DefaultNetworkService: NetworkServiceType {

    private let networkClient: MoyaProvider<MultiTarget>

    init() {
        networkClient = MoyaProvider<MultiTarget>()
    }

    func request<R: NetworkRequestType>(_ request: R) -> Single<Response> {
        let target = MultiTarget(request)
        return networkClient.rx.request(target)
    }
}
