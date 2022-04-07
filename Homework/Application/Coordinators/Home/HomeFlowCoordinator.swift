//
//  HomeFlowCoordinator.swift
//  Homework
//
//  Created by David on 2022/4/7.
//

import UIKit

final class HomeFlowCoordinator {

    var navigation: UINavigationController
    private let factory: HomeFlowFactory

    init(navigation: UINavigationController, factory: HomeFlowFactory) {
        self.navigation = navigation
        self.factory = factory
    }

    func start() {
        let home = factory.makeHomeView()
        navigation.viewControllers = [home]

        home.onSelectAsset = { [weak self] asset in
            self?.showAsset(asset: asset)
        }
    }

    func showAsset(asset: OpenSeaAsset) {
        let asset = factory.makeAssetDetailView(asset: asset)
        navigation.pushViewController(asset, animated: true)

        asset.onOpenPermalink = { [weak self] link in

        }
    }
}
