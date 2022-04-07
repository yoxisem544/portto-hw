//
//  AssetDetailViewModel.swift
//  Homework
//
//  Created by David on 2022/4/7.
//

import Foundation
import RxSwift
import RxCocoa
import RxRelay

final class AssetDetailViewModel {

    // Properties

    private let bag = DisposeBag()

    // Input & Output

    struct Input {
        let onClickPermalink: AnyObserver<Void>
    }

    struct Output {
        let asset: Driver<OpenSeaAsset>
        let onOpenPermalink: Driver<URL>
    }

    let input: Input
    let output: Output

    private let onClickPermalinkSubject = PublishSubject<Void>()

    private let assetSubject: BehaviorRelay<OpenSeaAsset>
    private let onOpenPermalinkSubject = PublishRelay<URL>()

    // Init

    init(asset: OpenSeaAsset) {
        self.assetSubject = BehaviorRelay<OpenSeaAsset>(value: asset)

        self.input = Input(
            onClickPermalink: onClickPermalinkSubject.asObserver()
        )

        self.output = Output(
            asset: assetSubject.asDriver(),
            onOpenPermalink: onOpenPermalinkSubject.asDriver(onErrorDriveWith: .empty())
        )

        onClickPermalinkSubject
            .map { [assetSubject] _ in
                assetSubject.value.permalink
            }
            .bind(to: onOpenPermalinkSubject)
            .disposed(by: bag)
    }
}
