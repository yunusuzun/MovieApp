//
//  CustomSearchBar.swift
//  MovieApp
//
//  Created by Yunus Uzun on 7.09.2023.
//

import UIKit

protocol CustomSearchBarDelegate: AnyObject {
    func searchBar(_ searchBar: CustomSearchBar, didChangeText text: String?)
}

final class CustomSearchBar: UITextField {
    private lazy var filterButton = createButton(imageName: "filter")
    private lazy var clearButton: UIButton = {
        let button = createButton(imageName: "delete")
        button.addTarget(self, action: #selector(clearText), for: .touchUpInside)
        return button
    }()
    
    weak var searchBarDelegate: CustomSearchBarDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension CustomSearchBar {
    func setupUI() {
        placeholder = "Search"
        setupViewStyles()
        
        rightView = createEmbeddedButtonView(button: clearButton)
        leftView = createEmbeddedButtonView(button: filterButton)
        
        addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }
    
    func setupViewStyles() {
        corner(8)
        layer.borderWidth = 2
        layer.borderColor = UIColor.lightGray.cgColor
        rightViewMode = .always
        textColor = .white
        leftViewMode = .always
    }
    
    func createButton(imageName: String) -> UIButton {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: imageName), for: .normal)
        button.contentMode = .scaleAspectFit
        button.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        return button
    }
    
    func createEmbeddedButtonView(button: UIButton) -> UIView {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        view.addSubview(button)
        button.frame = view.bounds
        return view
    }
    
    @objc func textDidChange() {
        clearButton.isHidden = text?.isEmpty == true
        searchBarDelegate?.searchBar(self, didChangeText: text)
    }
    
    @objc func clearText() {
        text = .empty
        textDidChange()
    }
}
