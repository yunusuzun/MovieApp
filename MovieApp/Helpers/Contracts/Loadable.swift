//
//  Loadable.swift
//  MovieApp
//
//  Created by Yunus Uzun on 10.09.2023.
//

import class UIKit.UIViewController

protocol Loadable {
    func displayLoading(_ shouldDisplay: Bool)
}

extension Loadable where Self: UIViewController {
    func displayLoading(_ shouldDisplay: Bool) {
        let loadingIndicator = LoadingIndicatorBuilder.make()

        if shouldDisplay {
            present(loadingIndicator, animated: true)
        } else {
            if let loadingIndicator = presentedViewController as? LoadingIndicator {
                loadingIndicator.dismiss(animated: true)
            }
        }
    }
}
