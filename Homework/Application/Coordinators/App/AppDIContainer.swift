//
//  AppDIContainer.swift
//  Homework
//
//  Created by David on 2022/4/7.
//

import Foundation

final class AppDIContainer {

    func makeOpenSeaUseCase() -> OpenSeaUseCaseType {
        OpenSeaUseCase()
    }
}
