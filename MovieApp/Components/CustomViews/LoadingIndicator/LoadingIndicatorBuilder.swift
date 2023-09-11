//
//  LoadingIndicatorBuilder.swift
//  MovieApp
//
//  Created by Yunus Uzun on 7.09.2023.
//

struct LoadingIndicatorBuilder {
    static func make() -> LoadingIndicator {
        let view = LoadingIndicator()
        view.modalTransitionStyle = .crossDissolve
        view.modalPresentationStyle = .overCurrentContext
        return view
    }
}
