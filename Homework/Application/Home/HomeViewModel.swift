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
    private let ethUseCase: ETHUseCaseType

    private var bag = DisposeBag()

    private let address = "0x19818f44faf5a217f619aff0fd487cb2a55cca65"

    // Input & Output

    struct Input {
        let onLoad: AnyObserver<Void>
        let onSelectIndex: AnyObserver<Int>
    }

    struct Output {
        let assets: BehaviorRelay<[OpenSeaAsset]>
        let doesReachEnd: BehaviorRelay<Bool>
        let onSelectAsset: Driver<OpenSeaAsset?>
        let ethAmount: Driver<String>
    }

    let input: Input
    let output: Output

    private let onLoadSubject = PublishSubject<Void>()
    private let onSelectIndexSubject = PublishSubject<Int>()

    private let assetsSubject = BehaviorRelay<[OpenSeaAsset]>(value: [])
    private let nextCursorSubject = BehaviorRelay<String?>(value: nil)
    private let doesReachEndSubject = BehaviorRelay<Bool>(value: false)
    private let onSelectAssetSubject = PublishSubject<OpenSeaAsset?>()
    private let ethAmountSubject = BehaviorRelay<String>(value: "- ETH")

    // Init

    init(openSeaUseCase: OpenSeaUseCaseType, ethUseCase: ETHUseCaseType) {
        self.openSeaUseCase = openSeaUseCase
        self.ethUseCase = ethUseCase

        self.input = Input(
            onLoad: onLoadSubject.asObserver(),
            onSelectIndex: onSelectIndexSubject.asObserver()
        )

        self.output = Output(
            assets: assetsSubject,
            doesReachEnd: doesReachEndSubject,
            onSelectAsset: onSelectAssetSubject.asDriver(onErrorDriveWith: .empty()),
            ethAmount: ethAmountSubject.asDriver(onErrorDriveWith: .empty())
        )

        onLoadSubject
            .filter { [doesReachEndSubject] _ in doesReachEndSubject.value == false }
            .withUnretained(self)
            .flatMapLatest { owner, _ in
                return owner.openSeaUseCase.fetchAssets(of: owner.address, cursor: owner.nextCursorSubject.value)
                    .asObservable()
                    .catch { _ in return Observable.empty() } // handle error here
            }
            .subscribe { [assetsSubject, nextCursorSubject, doesReachEndSubject] ob in
                switch ob {
                case .next(let nextResult):
                    assetsSubject.accept(assetsSubject.value + nextResult.assets)
                    nextCursorSubject.accept(nextResult.next)

                    let isEnd = nextResult.next == nil
                    doesReachEndSubject.accept(isEnd)

                default:
                    break
                }
            }
            .disposed(by: bag)

        ethUseCase.fetchETHAmount(of: address)
            .asObservable()
            .catch { e in
                print(e)
                return .empty()
            }
            .map { amount -> String? in
                let formatter = NumberFormatter()
                formatter.maximumFractionDigits = 10
                formatter.minimumFractionDigits = 10
                formatter.numberStyle = .decimal

                return formatter.string(for: amount)
            }
            .map { amount -> String in
                if let amount = amount {
                    return "\(amount) ETH"
                } else {
                    return "- ETH"
                }
            }
            .asObservable()
            .bind(to: ethAmountSubject)
            .disposed(by: bag)

        onSelectIndexSubject
            .map { [assetsSubject] assetIndex -> OpenSeaAsset? in
                if assetIndex < assetsSubject.value.count {
                    let asset = assetsSubject.value[assetIndex]
                    return asset
                } else {
                    return nil
                }
            }
            .bind(to: onSelectAssetSubject)
            .disposed(by: bag)
    }
}
