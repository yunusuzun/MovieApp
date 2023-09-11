//
//  Alertable.swift
//  MovieApp
//
//  Created by Yunus Uzun on 8.09.2023.
//

import class UIKit.UIViewController

protocol Alertable {
    func showAlert(title: String, message: String)
}

extension Alertable where Self: UIViewController {
    func showAlert(title: String, message: String) {
        let customAlert = CustomAlertBuilder.make(title: title, message: message)
        present(customAlert, animated: true)
    }
}
