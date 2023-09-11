//
//  DetailInfoView.swift
//  MovieApp
//
//  Created by Yunus Uzun on 10.09.2023.
//

import UIKit

final class DetailInfoView: UIView {
    private lazy var infoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 2
        stackView.distribution = .fill
        stackView.alignment = .center
        return stackView
    }()
    
    private lazy var titleLabel = CustomLabel()
    private lazy var descriptionLabel = CustomLabel()
    
    func configure(title: String, description: String) {
        addSubview(infoStackView)
        infoStackView.addArrangedSubview(titleLabel)
        infoStackView.addArrangedSubview(descriptionLabel)
        infoStackView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
        titleLabel.setProperties(text: title, fontColor: .gray, fontSize: 15, weight: .semibold)
        titleLabel.numberOfLines = 1
        descriptionLabel.setProperties(text: description, fontColor: .white, fontSize: 17, weight: .semibold)
        descriptionLabel.textAlignment = .center
    }
}
