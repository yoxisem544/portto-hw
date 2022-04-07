//
//  AppFlowFactory.swift
//  Homework
//
//  Created by David on 2022/4/7.
//

import UIKit

final class AppFlowFactory {

    private let diContainer: AppDIContainer

    init(diContainer: AppDIContainer) {
        self.diContainer = diContainer
    }

    func makeHomeFlowCoordinator(navigation: UINavigationController) -> HomeFlowCoordinator {
        let factory = HomeFlowFactory(diContainer: diContainer)
        return HomeFlowCoordinator(navigation: navigation, factory: factory)
    }
}
