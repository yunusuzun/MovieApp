//
//  CustomLabel.swift
//  MovieApp
//
//  Created by Yunus Uzun on 7.09.2023.
//

import UIKit

final class CustomLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setProperties(text: String, fontColor: UIColor, fontSize: CGFloat, weight: UIFont.Weight = .regular) {
        self.text = text
        textColor = fontColor
        font = UIFont.systemFont(ofSize: fontSize, weight: weight)
        textAlignment = .left
        numberOfLines = 0
    }
}
