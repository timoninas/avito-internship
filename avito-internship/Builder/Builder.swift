//
//  Builder.swift
//  avito-internship
//
//  Created by Антон Тимонин on 13.01.2021.
//

import UIKit

protocol BuilderProtocol: class {
    func buildMainModule() -> UIViewController
}

class Builder: BuilderProtocol {
    func buildMainModule() -> UIViewController {
        let view = ViewMain()
        let presenter = PresenterMain(view: view)
        view.presenter = presenter
        return view
    }
}
