//
//  AppFlowCoordinator.swift
//  Homework
//
//  Created by David on 2022/4/7.
//

import UIKit

final class AppFlowCoordinator {

    var navigation: UINavigationController
    private let factory: AppFlowFactory

    init(navigation: UINavigationController, factory: AppFlowFactory) {
        self.navigation = navigation
        self.factory = factory
    }

    func start() {
        let homeFlow = factory.makeHomeFlowCoordinator(navigation: navigation)
        homeFlow.start()
    }
}
