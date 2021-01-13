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
    init(view: MainInputProtocol)
    func fetchData()
}

class PresenterMain: MainOutputProtocol {
    let view: MainInputProtocol!
    
    required init(view: MainInputProtocol) {
        self.view = view
    }
    
    func fetchData() {
    }
}
