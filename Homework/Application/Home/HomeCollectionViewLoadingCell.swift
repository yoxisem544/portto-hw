//
//  HomeCollectionViewLoadingCell.swift
//  Homework
//
//  Created by David on 2022/4/7.
//

import UIKit

final class HomeCollectionViewLoadingCell: UICollectionViewCell {

    // MARK: - ๐ Constants
    // MARK: - ๐ถ Properties
    // MARK: - ๐จ Style
    // MARK: - ๐งฉ Subviews

    private let loadingView = UIActivityIndicatorView()

    // MARK: - ๐ Actions
    // MARK: - ๐จ Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - ๐ผ View Lifecycle

    // MARK: - ๐ UI

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

    // MARK: - ๐ Public Methods

    override func prepareForReuse() {
        super.prepareForReuse()

        loadingView.stopAnimating()
    }

    func startLoading() {
        loadingView.startAnimating()
    }

    // MARK: - ๐ Private Methods

}

// MARK: - ๐งถ Extensions
