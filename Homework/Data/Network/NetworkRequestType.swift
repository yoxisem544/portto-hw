//
//  NetworkRequestType.swift
//  Homework
//
//  Created by David on 2022/4/6.
//

import Foundation
import Moya

protocol NetworkRequestType: TargetType {
    var parameters: [String: Any] { get }
}

extension NetworkRequestType {
    var headers: [String: String]? { [:] }
    var sampleData: Data { Data() }
    var parameters: [String: Any] { [:] }
}

extension NetworkRequestType {

    var method: Moya.Method { .get }

    var task: Task {
        if parameters.isEmpty {
            return .requestPlain
        } else {
            if method == .get {
                return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
            } else {
                return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
            }
        }
    }
}
