//
//  CustomAlertBuilder.swift
//  MovieApp
//
//  Created by Yunus Uzun on 8.09.2023.
//

import UIKit

struct CustomAlertBuilder {
    static func make(title: String, message: String) -> CustomAlert {
        let view = CustomAlert(alertTitle: title, message: message)
        view.modalTransitionStyle = .crossDissolve
        view.modalPresentationStyle = .overCurrentContext
        return view
    }
}
