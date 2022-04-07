//
//  HomeCollectionViewLoadingCell.swift
//  Homework
//
//  Created by David on 2022/4/7.
//

import UIKit

final class HomeCollectionViewLoadingCell: UICollectionViewCell {

    // MARK: - 📌 Constants
    // MARK: - 🔶 Properties
    // MARK: - 🎨 Style
    // MARK: - 🧩 Subviews

    private let loadingView = UIActivityIndicatorView()

    // MARK: - 👆 Actions
    // MARK: - 🔨 Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - 🖼 View Lifecycle

    // MARK: - 🏗 UI

    private func setupUI() {
        contentView.addSubview(loadingView)
        loadingView.translatesAutoresizingMaskIntoConstraints = false

        let bottomConstraint = loadingView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24)
        bottomConstraint.priority -= 1

        NSLayoutConstraint.activate([
            loadingView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24),
            bottomConstraint,
            loadingView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            loadingView.heightAnchor.constraint(equalToConstant: 20),
            loadingView.widthAnchor.constraint(equalToConstant: 20)
        ])

        loadingView.startAnimating()
    }

    // MARK: - 🚌 Public Methods

    override func prepareForReuse() {
        super.prepareForReuse()

        loadingView.stopAnimating()
    }

    func startLoading() {
        loadingView.startAnimating()
    }

    // MARK: - 🔒 Private Methods

}

// MARK: - 🧶 Extensions
