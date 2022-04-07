//
//  AssetDetailViewController.swift
//  Homework
//
//  Created by David on 2022/4/7.
//

import UIKit

protocol AssetDetailViewOutput: AnyObject {

}

final class AssetDetailViewController: UIViewController, AssetDetailViewOutput {

    // MARK: - 📌 Constants
    // MARK: - 🔶 Properties

    private let viewModel: AssetDetailViewModel

    // MARK: - 🎨 Style
    // MARK: - 🧩 Subviews
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
    }

    // MARK: - 🏗 UI

    private func setupUI() {
        view.backgroundColor = .white
    }

    // MARK: - 🚌 Public Methods
    // MARK: - 🔒 Private Methods

}

// MARK: - 🧶 Extensions
