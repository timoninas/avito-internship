//
//  Presenter.swift
//  avito-internship
//
//  Created by Антон Тимонин on 13.01.2021.
//

import Foundation

protocol MainInputProtocol: class {
    func success()
    func failure()
}

protocol MainOutputProtocol: class {
    init(view: MainInputProtocol, networkService: NetworkServiceProtocol)
    func fetchData()
    func getSuggestion() -> [List]?
    func getTitle() -> String?
}

class PresenterMain: MainOutputProtocol {
    let view: MainInputProtocol!
    let networkService: NetworkServiceProtocol
    var suggestions: [List]?
    var title: String?
    
    required init(view: MainInputProtocol, networkService: NetworkServiceProtocol) {
        self.view = view
        self.networkService = networkService
    }
    
    func fetchData() {
        networkService.fetchCatalog { [weak self] (result) in
            switch result {
            case .failure(let error):
                print(error)
                break
            case .success(let welcome):
                guard let self = self else { return }
                guard let welcome = welcome else { return }
                self.suggestions = welcome.result.list
                self.title = welcome.result.title
                self.view.success()
                break
            }
        }
    }
    
    func getSuggestion() -> [List]? {
        return suggestions
    }
    
    func getTitle() -> String? {
        return title
    }
}
