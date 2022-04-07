//
//  HomeCellectionViewCell.swift
//  Homework
//
//  Created by David on 2022/4/6.
//

import UIKit
import Kingfisher

final class HomeCellectionViewCell: UICollectionViewCell {

    // MARK: - 📌 Constants
    // MARK: - 🔶 Properties

    var assetImageURL: String? {
        didSet {
            let url: URL? = {
                if let assetImageURL = assetImageURL {
                    return URL(string: assetImageURL)
                }
                return nil
            }()

            assetImageView.kf.setImage(with: url)
        }
    }

    var name: String? {
        didSet {
            nameLabel.text = name
        }
    }

    // MARK: - 🎨 Style
    // MARK: - 🧩 Subviews

    private let assetImageView = UIImageView()
    private let nameLabel = UILabel()

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
        contentView.addSubview(assetImageView)
        contentView.addSubview(nameLabel)
        [assetImageView, nameLabel].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }

        assetImageView.clipsToBounds = true
        assetImageView.contentMode = .scaleAspectFill

        nameLabel.textAlignment = .center

        NSLayoutConstraint.activate([
            assetImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            assetImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            assetImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),

            nameLabel.topAnchor.constraint(equalTo: assetImageView.bottomAnchor, constant: 12),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])

        let squareConstraint = assetImageView.widthAnchor.constraint(equalTo: assetImageView.heightAnchor)
        squareConstraint.priority -= 1
        squareConstraint.isActive = true

        backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
        layer.cornerRadius = 4
    }

    // MARK: - 🚌 Public Methods
    // MARK: - 🔒 Private Methods

}

// MARK: - 🧶 Extensions
