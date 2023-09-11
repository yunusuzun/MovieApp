//
//  LoadingIndicator.swift
//  MovieApp
//
//  Created by Yunus Uzun on 7.09.2023.
//

import UIKit

final class LoadingIndicator: UIViewController {
    let containerView = UIView()
    let label = CustomLabel()
    let activityIndicator = UIActivityIndicatorView()
    let stackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.spacing = 10
        sv.alignment = .center
        sv.distribution = .fill
        return sv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        label.setProperties(text: "Lütfen bekleyin!", fontColor: .black, fontSize: 15)
        view.addSubview(containerView)
        containerView.addSubview(stackView)
        stackView.addArrangedSubview(activityIndicator)
        stackView.addArrangedSubview(label)
        stackView.anchor(height: 50)
        view.backgroundColor = .black.withAlphaComponent(0.4)
        containerView.centerInSuperview()
        activityIndicator.color = .black
        activityIndicator.startAnimating()
        containerView.backgroundColor = .white
        containerView.corner(10)
        stackView.centerInSuperview()
        stackView.anchor(top: containerView.topAnchor, leading: containerView.leadingAnchor, bottom: containerView.bottomAnchor, trailing: containerView.trailingAnchor, paddingLeft: 30, paddingRight: 30)
    }
}
