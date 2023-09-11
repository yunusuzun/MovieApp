//
//  MovieHomePresenter.swift
//  MovieApp
//
//  Created by Yunus Uzun on 7.09.2023.
//

import Foundation

protocol MovieHomePresenterProtocol: AnyObject {
    var tableViewRowCount: Int { get }
    var collectionViewItemCount: Int { get }
    
    func load()
    func didSelectItem(at indexPath: IndexPath)
    func cellForTableView(at row: Int) -> MoviePresentation
    func cellForCollectionView(at item: Int) -> MoviePresentation
    func paginateForTableView(at indexPath: IndexPath)
    func paginateForCollectionView(at indexPath: IndexPath)
    func textSearched(text: String)
    func didSelectRow(at indexPath: IndexPath)
    func viewWillAppear()
}

final class MovieHomePresenter {
    private weak var view: MovieHomeViewProtocol?
    private let interactor: MovieHomeInteractorProtocol
    private let router: MovieHomeRouterProtocol
    private var tableMovies: [MoviePresentation] = []
    private var collectionMovies: [MoviePresentation] = []
    private var tableViewPage: Int = 1
    private var collectionViewPage: Int = 1
    private var searchText: String = "Star"
    private var group = DispatchGroup()
    private var searchDebounceTimer: Timer?
    private let debounceInterval: TimeInterval = 0.5
    
    init(interactor: MovieHomeInteractorProtocol, router: MovieHomeRouterProtocol, view: MovieHomeViewProtocol?) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension MovieHomePresenter: MovieHomePresenterProtocol {
    
    func viewWillAppear() {
        view?.handle(.configureNavBar)
    }
    
    func didSelectItem(at indexPath: IndexPath) {
        if let id = collectionMovies[indexPath.row].imdbID {
            router.navigate(to: .detail(id: id))
        }
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        if let id = tableMovies[indexPath.row].imdbID {
            router.navigate(to: .detail(id: id))
        }
    }
    
    var tableViewRowCount: Int {
        tableMovies.count
    }
    
    var collectionViewItemCount: Int {
        collectionMovies.count
    }
    
    func textSearched(text: String) {
        searchDebounceTimer?.invalidate()
        
        searchDebounceTimer = Timer.scheduledTimer(withTimeInterval: debounceInterval, repeats: false) { [weak self] _ in
            guard let self = self else { return }
                    
            searchText = text
            view?.displayLoading(true)
            tableViewPage = 1
            tableMovies = []
            view?.handle(.tableViewReloadData)
            interactor.load(query: queryHelper.table) { [weak self] result in
                switch result {
                case .success(let movie):
                    if let movies = movie.search?.map(MoviePresentation.init) {
                        self?.tableMovies.append(contentsOf: movies)
                    }
                case .failure(let error):
                    self?.view?.showAlert(title: "Oppss!", message: error.localizedDescription)
                }
                
                self?.view?.handle(.tableViewReloadData)
                self?.view?.displayLoading(false)
            }
        }
    }
    
    func load() {
        view?.displayLoading(true)
        view?.handle(.prepareView)
        
        fetchTableMoview()
        fetchCollectionMoview()
        
        group.notify(queue: .main) {
            self.view?.displayLoading(false)
           
            self.view?.handle(.collectionViewReloadData)
            self.view?.handle(.tableViewReloadData)
        }
    }
    
    func fetchTableMoview() {
        group.enter()
        
        interactor.load(query: queryHelper.table) { [weak self] result in
            switch result {
            case .success(let movie):
                if let movies = movie.search?.map(MoviePresentation.init) {
                    self?.tableMovies.append(contentsOf: movies)
                    self?.tableViewPage += 1
                }
            case .failure(let error):
                self?.view?.showAlert(title: "Oppss!", message: error.localizedDescription)
            }
            
            self?.group.leave()
        }
    }
    
    func fetchCollectionMoview() {
        group.enter()
        interactor.load(query: queryHelper.collection) { [weak self] result in
            switch result {
            case .success(let movie):
                if let movies = movie.search?.map(MoviePresentation.init) {
                    self?.collectionMovies.append(contentsOf: movies)
                    self?.collectionViewPage += 1
                }
            case .failure(let error):
                self?.view?.showAlert(title: "Oppss!", message: error.localizedDescription)
            }
            
            self?.group.leave()
        }
    }
    
    func cellForTableView(at row: Int) -> MoviePresentation {
        tableMovies[row]
    }
    
    func cellForCollectionView(at item: Int) -> MoviePresentation {
        collectionMovies[item]
    }
    
    func paginateForTableView(at indexPath: IndexPath) {
        if indexPath.row == tableViewRowCount - 1 {
            interactor.load(query: queryHelper.table) { [weak self] result in
                switch result {
                case .success(let movie):
                    if let movies = movie.search?.map(MoviePresentation.init) {
                        self?.tableMovies.append(contentsOf: movies)
                        self?.tableViewPage += 1
                        self?.view?.handle(.tableViewReloadData)
                    }
                case .failure(let error):
                    self?.view?.showAlert(title: "Oppss!", message: error.localizedDescription)
                }
            }
        }
    }
    
    func paginateForCollectionView(at indexPath: IndexPath) {
        if indexPath.item == collectionViewItemCount - 1 {
            interactor.load(query: queryHelper.collection) { [weak self] result in
                switch result {
                case .success(let movie):
                    if let movies = movie.search?.map(MoviePresentation.init) {
                        self?.collectionMovies.append(contentsOf: movies)
                        self?.collectionViewPage += 1
                    }
                case .failure(let error):
                    self?.view?.showAlert(title: "Oppss!", message: error.localizedDescription)
                }
                
                self?.view?.handle(.collectionViewReloadData)
            }
        }
    }
}


private extension MovieHomePresenter {
    var queryHelper: (table: [String: Any], collection: [String: Any]) {
        (table: ["s": searchText, "page": tableViewPage, "apikey": APIConstants.apiKey], collection: ["s": "Comedy", "page": collectionViewPage, "apikey": APIConstants.apiKey])
    }
}
