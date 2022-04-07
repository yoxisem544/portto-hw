//
//  AppFlowCoordinator.swift
//  Homework
//
//  Created by David on 2022/4/7.
//

import UIKit

final class AppFlowCoordinator: CoordinatorType {

    var navigation: UINavigationController
    private let factory: AppFlowFactory

    var children: [CoordinatorType]

    init(navigation: UINavigationController, factory: AppFlowFactory) {
        self.navigation = navigation
        self.factory = factory
        self.children = []
    }

    func start() {
        let homeFlow = factory.makeHomeFlowCoordinator(navigation: navigation)
        children.append(homeFlow) // remove when flow ends
        homeFlow.start()
    }
}
