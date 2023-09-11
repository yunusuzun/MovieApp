//
//  CustomAlert.swift
//  MovieApp
//
//  Created by Yunus Uzun on 8.09.2023.
//

import UIKit

final class CustomAlert: UIViewController {
    private let containerView = UIView()
    private let titleLabel = CustomLabel()
    private let messageLabel = CustomLabel()
    private lazy var okButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("OK", for: .normal)
        button.tintColor = .red
        button.anchor(height: 50)
        button.addTarget(self, action: #selector(dismissClicked), for: .touchUpInside)
        return button
    }()
    
    private let alertTitle: String
    private let message: String
    private let stackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = 3
        sv.alignment = .center
        sv.distribution = .fill
        return sv
    }()
    
    init(alertTitle: String, message: String) {
        self.alertTitle = alertTitle
        self.message = message
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.setProperties(text: alertTitle, fontColor: .black, fontSize: 20, weight: .medium)
        messageLabel.textAlignment = .center
        messageLabel.setProperties(text: message, fontColor: .gray, fontSize: 17, weight: .regular)
        view.addSubview(containerView)
        containerView.addSubview(stackView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(messageLabel)
        stackView.addArrangedSubview(okButton)
        view.backgroundColor = .black.withAlphaComponent(0.4)
        containerView.centerInSuperview()
        containerView.anchor(leading: view.leadingAnchor, trailing: view.trailingAnchor, paddingLeft: 30, paddingRight: 30)
        containerView.backgroundColor = .white
        containerView.corner(10)
        stackView.anchor(top: containerView.topAnchor, leading: containerView.leadingAnchor, bottom: containerView.bottomAnchor, trailing: containerView.trailingAnchor, paddingTop: 15, paddingLeft: 30, paddingBottom: 15, paddingRight: 30)
    }
    
    @objc private func dismissClicked() {
        dismiss(animated: true)
    }
}
