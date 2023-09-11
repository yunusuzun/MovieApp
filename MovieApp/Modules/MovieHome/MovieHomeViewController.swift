//
//  MovieHomeViewController.swift
//  MovieApp
//
//  Created by Yunus Uzun on 7.09.2023.
//

import UIKit

protocol MovieHomeViewProtocol: AnyObject, Loadable, Alertable {
    func handle(_ output: MovieListPresenterOutput)
}

enum MovieListPresenterOutput {
    case tableViewReloadData
    case collectionViewReloadData
    case prepareView
    case configureNavBar
}

final class MovieHomeViewController: UIViewController {
    private lazy var customSearchBar = CustomSearchBar()
    private lazy var titleLabel = CustomLabel()
    private lazy var tableView = UITableView()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.showsHorizontalScrollIndicator = false
        return cv
    }()
    
    var presenter: MovieHomePresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.load()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter.viewWillAppear()
    }
}

// MARK: MovieHomeViewProtocol
extension MovieHomeViewController: MovieHomeViewProtocol {
    func handle(_ output: MovieListPresenterOutput) {
        switch output {
        case .tableViewReloadData:
            tableView.reloadData()
        case .collectionViewReloadData:
            collectionView.reloadData()
        case .prepareView:
            tableView.delegate = self
            tableView.dataSource = self
            tableView.backgroundColor = .clear
            tableView.separatorStyle = .none
            tableView.register(cellClass: MovieTableViewCell.self)
            
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.register(cellClass: MovieCollectionViewCell.self)
            
            customSearchBar.searchBarDelegate = self
            customSearchBar.text = "Star"
            
            view.backgroundColor = .background
            
            dismissKeyboard()
            setupSearchBar()
        case .configureNavBar:
            navigationController?.setNavigationBarHidden(true, animated: false)
        }
    }
}

// MARK: UICollectionViewDelegate, UICollectionViewDataSource
extension MovieHomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.collectionViewItemCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: MovieCollectionViewCell.self, for: indexPath)
        let movie = presenter.cellForCollectionView(at: indexPath.item)
        cell.presenter = MovieCollectionViewCellPresenter(view: cell, movie: movie)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        presenter.paginateForCollectionView(at: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let inset: CGFloat = 20.0
        return UIEdgeInsets(top: 0, left: inset, bottom: 0, right: inset)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.didSelectItem(at: indexPath)
    }
}

// MARK: UITableViewDelegate, UITableViewDataSource
extension MovieHomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.tableViewRowCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: MovieTableViewCell.self, for: indexPath)
        let movie = presenter.cellForTableView(at: indexPath.row)
        cell.presenter = MovieTableViewCellPresenter(view: cell, movie: movie)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        presenter.paginateForTableView(at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelectRow(at: indexPath)
    }
}

// MARK: CustomSearchBarDelegate
extension MovieHomeViewController: CustomSearchBarDelegate {
    func searchBar(_ searchBar: CustomSearchBar, didChangeText text: String?) {
        presenter.textSearched(text: text!.stringByRemovingWhitespaces)
    }
}

// MARK: Private functions
private extension MovieHomeViewController {
    func setupSearchBar() {
        view.addSubview(customSearchBar)
        view.addSubview(titleLabel)
        view.addSubview(tableView)
        view.addSubview(collectionView)
        
        titleLabel.setProperties(text: "Movies & Series", fontColor: .white, fontSize: 22, weight: .bold)
        customSearchBar.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, paddingTop: 10, paddingLeft: 20, paddingRight: 20, height: 50)
        titleLabel.anchor(top: customSearchBar.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, paddingTop: 15, paddingLeft: 20, paddingRight: 20)
        tableView.anchor(top: titleLabel.bottomAnchor, leading: view.leadingAnchor, bottom: collectionView.topAnchor, trailing: view.trailingAnchor, paddingTop: 15, paddingLeft: 20, paddingBottom: 10, paddingRight: 20)
        collectionView.anchor(leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor, height: 150)
    }
}
