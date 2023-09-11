//
//  MovieCollectionViewCell.swift
//  MovieApp
//
//  Created by Yunus Uzun on 8.09.2023.
//

import UIKit

protocol MovieCollectionViewCellProtocol: AnyObject {
    func setTitle(_ text: String)
    func preparePosterImage(with url: String)
    func prepareCell()
}

final class MovieCollectionViewCell: UICollectionViewCell {
    let containerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.alignment = .center
        return stackView
    }()
    
    let titleLabel = CustomLabel()
    
    let posterImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    var presenter: MovieCollectionViewCellPresenterProtocol! {
        didSet {
            presenter.load()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        backgroundColor = .black
        corner(10)
    }
}

extension MovieCollectionViewCell: MovieCollectionViewCellProtocol {
    func setTitle(_ text: String) {
        titleLabel.setProperties(text: text, fontColor: .white, fontSize: 10)
        titleLabel.textAlignment = .center
    }
    
    func preparePosterImage(with url: String) {
        posterImageView.download(url: url)
    }
    
    func prepareCell() {
        addSubview(containerStackView)
        containerStackView.addArrangedSubview(posterImageView)
        containerStackView.addArrangedSubview(titleLabel)
        containerStackView.anchor(top: topAnchor, leading: leadingAnchor, trailing: trailingAnchor)
        titleLabel.numberOfLines = 3
        titleLabel.anchor(leading: leadingAnchor, trailing: trailingAnchor, paddingLeft: 3, paddingRight: 3)
        posterImageView.anchor(height: 100)
    }
}
