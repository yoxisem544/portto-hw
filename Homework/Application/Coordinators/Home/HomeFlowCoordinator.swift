//
//  HomeFlowCoordinator.swift
//  Homework
//
//  Created by David on 2022/4/7.
//

import UIKit

final class HomeFlowCoordinator: CoordinatorType {

    var navigation: UINavigationController
    private let factory: HomeFlowFactory

    var children: [CoordinatorType]

    init(navigation: UINavigationController, factory: HomeFlowFactory) {
        self.navigation = navigation
        self.factory = factory
        self.children = []
    }

    func start() {
        let home = factory.makeHomeView()
        navigation.viewControllers = [home]

        home.onSelectAsset = { [weak self] asset in
            self?.showAsset(asset: asset)
        }
    }

    private func showAsset(asset: OpenSeaAsset) {
        let asset = factory.makeAssetDetailView(asset: asset)
        navigation.pushViewController(asset, animated: true)

        asset.onOpenPermalink = { link in
            guard UIApplication.shared.canOpenURL(link) else { return }
            UIApplication.shared.open(link)
        }
    }
}
