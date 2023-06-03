//
//  HomeViewController.swift
//  Homework
//
//  Created by David on 2022/4/6.
//

import UIKit
import RxSwift

protocol HomeViewOutpupt: AnyObject {
    var onSelectAsset: ((OpenSeaAsset) -> Void)? { get set }
}

final class HomeViewController: UIViewController, HomeViewOutpupt {

    // MARK: - 📌 Constants
    // MARK: - 🔶 Properties

    var onSelectAsset: ((OpenSeaAsset) -> Void)?

    private let viewModel: HomeViewModel

    private let cellID = "cell_id"
    private let loadingCellID = "loading_cell_id"

    private let bag = DisposeBag()

    // MARK: - 🎨 Style
    // MARK: - 🧩 Subviews

    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())

    // MARK: - 👆 Actions
    // MARK: - 🔨 Initialization

    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - 🖼 View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        observeViewModelOutputs()
    }

    // MARK: - 🏗 UI

    private func setupUI() {
        collectionView.register(HomeCellectionViewCell.self, forCellWithReuseIdentifier: cellID)
        collectionView.register(HomeCollectionViewLoadingCell.self, forCellWithReuseIdentifier: loadingCellID)
        collectionView.delegate = self
        collectionView.dataSource = self

        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }

    // MARK: - Layout

    private func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { sectionIndex, env -> NSCollectionLayoutSection? in
            switch sectionIndex {
            case 0:
                let fraction: CGFloat = 1 / 2
                let inset: CGFloat = 4

                // Item
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(fraction), heightDimension: .estimated(80))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset)

                // Group
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(80))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

                // Section
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset)
                section.interGroupSpacing = inset

                return section

            case 1:
                let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                                                     heightDimension: .fractionalHeight(1)))

                let group = NSCollectionLayoutGroup.vertical(
                    layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(80)),
                    subitems: [item]
                )

                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = .init(top: 0, leading: 0, bottom: 12, trailing: 0)

                return section

            default:
                fatalError()
            }
        }
    }

    // MARK: - 🚌 Public Methods
    // MARK: - 🔒 Private Methods

    private func observeViewModelOutputs() {
        Observable.combineLatest(viewModel.output.assets, viewModel.output.doesReachEnd)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] _, _ in
                self?.collectionView.reloadData()
            })
            .disposed(by: bag)

        viewModel.output.onSelectAsset
            .asObservable()
            .compactMap { $0 }
            .subscribe(onNext: { [weak self] asset in
                self?.onSelectAsset?(asset)
            })
            .disposed(by: bag)

        viewModel.output.ethAmount
            .drive(navigationItem.rx.title)
            .disposed(by: bag)
    }
}

// MARK: - 🧶 Extensions

extension HomeViewController: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return viewModel.output.assets.value.count
        case 1:
            return viewModel.output.doesReachEnd.value ? 0 : 1
        default:
            fatalError()
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! HomeCellectionViewCell
            let asset = viewModel.output.assets.value[indexPath.row]
            cell.asset = asset
            return cell

        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: loadingCellID, for: indexPath) as! HomeCollectionViewLoadingCell
            return cell

        default:
            fatalError()
        }
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let cell = cell as? HomeCollectionViewLoadingCell {
            cell.startLoading()
            viewModel.input.onLoad.on(.next(()))
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            viewModel.input.onSelectIndex.on(.next(indexPath.item))
        }
    }
}
