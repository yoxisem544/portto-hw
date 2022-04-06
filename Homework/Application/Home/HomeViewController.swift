//
//  HomeViewController.swift
//  Homework
//
//  Created by David on 2022/4/6.
//

import UIKit

final class HomeViewController: UIViewController {

    // MARK: - 📌 Constants
    // MARK: - 🔶 Properties

    private let viewModel: HomeViewModel

    // MARK: - 🎨 Style
    // MARK: - 🧩 Subviews
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

        viewModel.input.onLoad.onNext(())
    }

    // MARK: - 🏗 UI

    private func setupUI() {

    }

    // MARK: - 🚌 Public Methods
    // MARK: - 🔒 Private Methods

}

// MARK: - 🧶 Extensions
