//
//  HomeViewModel.swift
//  Homework
//
//  Created by David on 2022/4/6.
//

import Foundation
import RxSwift
import RxCocoa
import RxRelay

final class HomeViewModel {

    // Properties

    private let openSeaUseCase: OpenSeaUseCaseType

    private var bag = DisposeBag()

    // Input & Output

    struct Input {
        let onLoad: AnyObserver<Void>
    }

    struct Output {
        let assets: BehaviorRelay<[OpenSeaAsset]>
        let doesReachEnd: BehaviorRelay<Bool>
    }

    let input: Input
    let output: Output

    private let onLoadSubject = PublishSubject<Void>()

    private let assetsSubject = BehaviorRelay<[OpenSeaAsset]>(value: [])
    private let offsetSubject = BehaviorRelay<Int>(value: 0)
    private let doesReachEndSubject = BehaviorRelay<Bool>(value: false)

    // Init

    init(openSeaUseCase: OpenSeaUseCaseType) {
        self.openSeaUseCase = openSeaUseCase

        self.input = Input(
            onLoad: onLoadSubject.asObserver()
        )

        self.output = Output(
            assets: assetsSubject,
            doesReachEnd: doesReachEndSubject
        )

        onLoadSubject
            .filter { [doesReachEndSubject] _ in doesReachEndSubject.value == false }
            .withUnretained(self)
            .flatMapLatest { owner, _ in
                return owner.openSeaUseCase.fetchAssets(of: "0x19818f44faf5a217f619aff0fd487cb2a55cca65", offset: owner.offsetSubject.value)
                    .asObservable()
                    .catch { _ in return Observable.empty() } // handle error here
            }
            .subscribe { [assetsSubject, offsetSubject, doesReachEndSubject] ob in
                switch ob {
                case .next(let nextAssets):
                    assetsSubject.accept(assetsSubject.value + nextAssets)
                    offsetSubject.accept(offsetSubject.value + nextAssets.count)
                    doesReachEndSubject.accept(nextAssets.isEmpty)

                default:
                    break
                }
            }
            .disposed(by: bag)
    }
}
