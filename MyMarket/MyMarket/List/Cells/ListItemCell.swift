//
//  ListItemCell.swift
//  MyMarket
//
//  Created by Jegathas Sivanesan on 20/07/2021.
//

import UIKit

class ListItemCell: UICollectionViewCell {

    static let reuseIdentifier = "ListItemCell"

    let posterView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = UIColor.darkGray
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        return imageView
    }()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 18.0)
        label.textColor = .black
        label.numberOfLines = 2
        return label
    }()

    let categoryLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Medium", size: 14)
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        return label
    }()

    lazy var urgentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.cornerRadius = 4
        label.layer.masksToBounds = true
        label.backgroundColor = .systemOrange
        label.textColor = .white
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 11)
        label.text = "  urgent  "
        return label
    }()

    var priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Medium", size: 14)
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        posterView.image = nil
        super.prepareForReuse()
    }

    func fill(item: List.ViewItem) {
        if let urlString = item.image, let url = URL(string: urlString) {
            posterView.load(url: url)
        }
        titleLabel.text = item.title
        categoryLabel.text = item.category
        urgentLabel.isHidden = !item.isUrgent
        priceLabel.text = "\(item.price)€"
    }
}

extension ListItemCell {
    func configure() {

        contentView.addSubview(posterView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(categoryLabel)
        contentView.addSubview(urgentLabel)
        contentView.addSubview(priceLabel)

        contentView.backgroundColor = .clear

        NSLayoutConstraint.activate([
            posterView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            posterView.topAnchor.constraint(equalTo: contentView.topAnchor),
            posterView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            posterView.heightAnchor.constraint(equalToConstant: 180),

            urgentLabel.topAnchor.constraint(equalTo: posterView.topAnchor, constant: 4),
            urgentLabel.leadingAnchor.constraint(equalTo: posterView.leadingAnchor, constant: 4),
            urgentLabel.heightAnchor.constraint(equalToConstant: 20),

            titleLabel.topAnchor.constraint(equalTo: posterView.bottomAnchor, constant: 4),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),

            categoryLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            categoryLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            categoryLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),

            priceLabel.trailingAnchor.constraint(equalTo: posterView.trailingAnchor),
            priceLabel.topAnchor.constraint(equalTo: categoryLabel.topAnchor)
            ])
    }
}
