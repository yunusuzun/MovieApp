//
//  MovieDetailViewController.swift
//  MovieApp
//
//  Created by Yunus Uzun on 8.09.2023.
//

import UIKit

protocol MovieDetailViewProtocol: AnyObject, Alertable {
    func handle(_ output: MovieDetailPresenterOutput)
}

enum MovieDetailPresenterOutput {
    case prepareView
    case preparePoster(String)
    case setTitle(String)
    case setYear(String)
    case setCountry(String)
    case setLenght(String)
    case setDescription(String)
    case showLoading(Bool)
    case prepareNavigationBar
}

final class MovieDetailViewController: UIViewController {
    private lazy var containerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.distribution = .fill
        stackView.alignment = .center
        return stackView
    }()
    
    private lazy var infoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 25
        stackView.distribution = .equalCentering
        stackView.alignment = .top
        return stackView
    }()
    
    let gradientView = UIView()
    
    private let titleLabel = CustomLabel()
    private let yearView = DetailInfoView()
    private let countryView = DetailInfoView()
    private let lenghtView = DetailInfoView()
    private let descriptionLabel = CustomLabel()
    private lazy var indicator = UIActivityIndicatorView()
    
    private lazy var posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    var presenter: MovieDetailPresenterProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.load()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter.viewWillAppear()
    }
}

// MARK: Outputs
extension MovieDetailViewController: MovieDetailViewProtocol {
    func handle(_ output: MovieDetailPresenterOutput) {
        switch output {
        case .prepareView:
            view.backgroundColor = .background
            view.addSubview(posterImageView)
            view.addSubview(indicator)
            view.addSubview(gradientView)
            view.addSubview(containerStackView)
            containerStackView.addArrangedSubview(titleLabel)
            containerStackView.addArrangedSubview(infoStackView)
            infoStackView.addArrangedSubview(yearView)
            infoStackView.addArrangedSubview(countryView)
            infoStackView.addArrangedSubview(lenghtView)
            containerStackView.addArrangedSubview(descriptionLabel)
            indicator.centerInSuperview()
            containerStackView.anchor(top: posterImageView.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, paddingTop: 25, paddingLeft: 20, paddingRight: 20)
            posterImageView.anchor(top: view.topAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, height: 300)
            gradientView.anchor(top: view.topAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, height: 300)
            setGradientBackground()
        case .preparePoster(let url):
            posterImageView.download(url: url)
        case .setTitle(let title):
            titleLabel.setProperties(text: title, fontColor: .white, fontSize: 25, weight: .black)
            titleLabel.textAlignment = .center
        case .setYear(let description):
            yearView.configure(title: "Year", description: description)
        case .setCountry(let description):
            countryView.configure(title: "Country", description: description)
        case .setLenght(let description):
            lenghtView.configure(title: "Lenght", description: description)
        case .setDescription(let description):
            descriptionLabel.setProperties(text: description, fontColor: .white.withAlphaComponent(0.9), fontSize: 15)
        case .showLoading(let isShow):
            if isShow {
                indicator.startAnimating()
                indicator.isHidden = false
            } else {
                indicator.stopAnimating()
                indicator.isHidden = true
            }
        case .prepareNavigationBar:
            navigationController?.setNavigationBarHidden(false, animated: true)
            navigationController?.navigationBar.tintColor = .white
        }
    }
    
    private func setGradientBackground() {
        let colorTop =  UIColor.clear.cgColor
        let colorBottom = UIColor.background?.cgColor
                    
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom!]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 300)
                
        gradientView.layer.insertSublayer(gradientLayer, at:0)
    }
}
