//
//  AssetDetailViewController.swift
//  Homework
//
//  Created by David on 2022/4/7.
//

import UIKit
import RxSwift

protocol AssetDetailViewOutput: AnyObject {
    var onOpenPermalink: ((URL) -> Void)? { get set }
}

final class AssetDetailViewController: UIViewController, AssetDetailViewOutput {

    // MARK: - 📌 Constants
    // MARK: - 🔶 Properties

    var onOpenPermalink: ((URL) -> Void)?

    private let viewModel: AssetDetailViewModel

    private var heightConstraint: NSLayoutConstraint?

    private let bag = DisposeBag()

    // MARK: - 🎨 Style
    // MARK: - 🧩 Subviews

    private let scrollView = UIScrollView()
    private let imageView = UIImageView()
    private let nameLabel = UILabel()
    private let descriptionLabel = UILabel()

    private let permalinkButton = UIButton(type: .system)

    // MARK: - 👆 Actions
    // MARK: - 🔨 Initialization

    init(viewModel: AssetDetailViewModel) {
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
        setupViewModelInputs()
        observeViewModelOutputs()
    }

    // MARK: - 🏗 UI

    private func setupUI() {
        view.backgroundColor = .white

        let permalinkContaierView = UIView()
        view.addSubview(permalinkContaierView)
        permalinkContaierView.translatesAutoresizingMaskIntoConstraints = false

        permalinkContaierView.addSubview(permalinkButton)
        permalinkButton.translatesAutoresizingMaskIntoConstraints = false
        permalinkContaierView.backgroundColor = UIColor(red: 0.92, green: 0.92, blue: 0.92, alpha: 1)

        permalinkButton.setTitle("Go to Link", for: .normal)
        permalinkButton.setTitleColor(.white, for: .normal)
        permalinkButton.titleLabel?.textAlignment = .center
        permalinkButton.backgroundColor = UIColor.gray

        NSLayoutConstraint.activate([
            permalinkContaierView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            permalinkContaierView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            permalinkContaierView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            permalinkButton.leadingAnchor.constraint(equalTo: permalinkContaierView.leadingAnchor, constant: 16),
            permalinkButton.trailingAnchor.constraint(equalTo: permalinkContaierView.trailingAnchor, constant: -16),
            permalinkButton.bottomAnchor.constraint(equalTo: permalinkContaierView.safeAreaLayoutGuide.bottomAnchor, constant: -8),
            permalinkButton.topAnchor.constraint(equalTo: permalinkContaierView.topAnchor, constant: 8)
        ])

        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: permalinkContaierView.topAnchor)
        ])

        scrollView.addSubview(imageView)
        scrollView.addSubview(nameLabel)
        scrollView.addSubview(descriptionLabel)

        [imageView, nameLabel, descriptionLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        nameLabel.numberOfLines = 0
        descriptionLabel.numberOfLines = 0

        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true

        heightConstraint = imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 1)

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor, constant: 24),

            imageView.leadingAnchor.constraint(equalTo: scrollView.layoutMarginsGuide.leadingAnchor, constant: 16),
            imageView.trailingAnchor.constraint(equalTo: scrollView.layoutMarginsGuide.trailingAnchor, constant: -16),
            heightConstraint!,

            nameLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 24),

            descriptionLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 12),

            descriptionLabel.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor, constant: -24)
        ])
    }

    private func setupViewModelInputs() {
        permalinkButton.rx.tap
            .asObservable()
            .map { _ in () }
            .bind(to: viewModel.input.onClickPermalink)
            .disposed(by: bag)
    }

    private func observeViewModelOutputs() {
        viewModel.output.asset
            .asObservable()
            .subscribe(
                onNext: { [weak self] asset in
                    self?.display(asset: asset)
                }
            )
            .disposed(by: bag)

        viewModel.output.onOpenPermalink
            .asObservable()
            .subscribe(
                onNext: { [weak self] link in
                    self?.onOpenPermalink?(link)
                }
            )
            .disposed(by: bag)
    }

    // MARK: - 🚌 Public Methods
    // MARK: - 🔒 Private Methods

    private func display(asset: OpenSeaAsset) {
        let url = URL(string: asset.imageURL ?? "")

        imageView.kf.setImage(
            with: url,
            completionHandler: { [weak self] result in
                switch result {
                case .success(let imageResult):
                    guard let self = self else { return }
                    // resize width & height autolayout multiplier
                    let ratio = imageResult.image.size.height / imageResult.image.size.width
                    self.heightConstraint?.isActive = false
                    self.heightConstraint = self.imageView.heightAnchor.constraint(equalTo: self.imageView.widthAnchor, multiplier: ratio)
                    self.heightConstraint?.isActive = true
                    self.imageView.setNeedsUpdateConstraints()
                    self.imageView.layoutIfNeeded()
                    self.view.updateConstraints()

                case .failure:
                    break
                }
            }
        )

        let color = asset.backgroundColorHexString?.hexColor ?? .black // for default svg color
        imageView.backgroundColor = color

        nameLabel.text = asset.name ?? asset.collectionName
        descriptionLabel.text = asset.description

        navigationItem.title = asset.collectionName
    }
}

// MARK: - 🧶 Extensions
