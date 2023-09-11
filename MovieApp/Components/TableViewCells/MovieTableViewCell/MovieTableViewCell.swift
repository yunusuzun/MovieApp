//
//  MovieTableViewCell.swift
//  MovieApp
//
//  Created by Yunus Uzun on 7.09.2023.
//

import UIKit

protocol MovieTableViewCellProtocol: AnyObject {
    func setTitle(_ text: String)
    func setYear(_ text: String)
    func setType(_ text: String)
    func preparePosterImage(with url: String)
    func prepareCell()
}

final class MovieTableViewCell: UITableViewCell {
    let containerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 15
        return stackView
    }()
    
    let infoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 7
        stackView.alignment = .leading
        return stackView
    }()
    
    let bottomStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 7
        stackView.alignment = .center
        return stackView
    }()
    
    let yearLabel = CustomLabel()
    let titleLabel = CustomLabel()
    let typeLabel = CustomLabel()
    
    let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let playImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "play")
        imageView.sizeToFit()
        imageView.tintColor = .red.withAlphaComponent(0.7)
        return imageView
    }()
    
    var presenter: MovieTableViewCellPresenterProtocol! {
        didSet {
            presenter.load()
        }
    }
}

extension MovieTableViewCell: MovieTableViewCellProtocol {
    func prepareCell() {
        selectionStyle = .none
        backgroundColor = .clear
        posterImageView.anchor(width: 100, height: 140)
        posterImageView.corner(10)
        addSubview(containerStackView)
        containerStackView.addArrangedSubview(posterImageView)
        containerStackView.addArrangedSubview(infoStackView)
        infoStackView.addArrangedSubview(yearLabel)
        infoStackView.addArrangedSubview(titleLabel)
        infoStackView.addArrangedSubview(bottomStackView)
        bottomStackView.addArrangedSubview(playImageView)
        bottomStackView.addArrangedSubview(typeLabel)
        playImageView.anchor(width: 40, height: 40)
    
        containerStackView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, paddingBottom: 20)
    }
    
    func setTitle(_ text: String) {
        titleLabel.setProperties(text: text, fontColor: .white, fontSize: 18, weight: .bold)
    }
    
    func setYear(_ text: String) {
        yearLabel.setProperties(text: text, fontColor: .gray, fontSize: 13, weight: .bold)
    }

    func setType(_ text: String) {
        typeLabel.setProperties(text: text, fontColor: .gray, fontSize: 15, weight: .medium)
    }
    
    func preparePosterImage(with url: String) {
        posterImageView.download(url: url)
    }
}
