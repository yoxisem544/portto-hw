//
//  HomeFlowFactory.swift
//  Homework
//
//  Created by David on 2022/4/7.
//

import Foundation

final class HomeFlowFactory {

    private let diContainer: AppDIContainer

    init(diContainer: AppDIContainer) {
        self.diContainer = diContainer
    }

    func makeHomeView() -> HomeViewController {
        let vm = HomeViewModel(
            openSeaUseCase: diContainer.makeOpenSeaUseCase(),
            ethUseCase: diContainer.makeETHUseCase()
        )
        let vc = HomeViewController(viewModel: vm)
        return vc
    }

    func makeAssetDetailView(asset: OpenSeaAsset) -> AssetDetailViewController {
        let vm = AssetDetailViewModel(asset: asset)
        let vc = AssetDetailViewController(viewModel: vm)
        return vc
    }
}
