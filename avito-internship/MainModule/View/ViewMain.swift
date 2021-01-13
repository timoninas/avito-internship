//
//  ViewController.swift
//  avito-internship
//
//  Created by Антон Тимонин on 13.01.2021.
//

import UIKit

struct Suggestion {
    let title: String
    let description: String?
    let icon: String
    let price: String
    let isSelected: Bool
}

let suggestionStatic = [
    Suggestion(title: "XL объявление", description: "Пользователи смогут посмотреть фотографии, описание и телефон прямо из результатов поиска.",  icon: "https://www.avito.ru/s/common/components/monetization/icons/apps/vas-xl-52.png", price: "356 ₽", isSelected: true),
    Suggestion(title: "Выделение", description: "Яркий цвет не даст затеряться среди других объявлений.",  icon: "https://www.avito.ru/s/common/components/monetization/icons/apps/vas-highlight-52.png", price: "299 ₽", isSelected: true),
    Suggestion(title: "До 10 раз больше просмотров на 1 день", description: nil, icon: "https://www.avito.ru/s/common/components/monetization/icons/apps/vas-x10_1-52.png", price: "400 ₽", isSelected: false),
    Suggestion(title: "До 2 раз больше просмотров на 1 день", description: nil, icon: "https://www.avito.ru/s/common/components/monetization/icons/apps/vas-x2_1-52.png", price: "100 ₽", isSelected: false)
]

class ViewMain: UIViewController {
    var presenter: MainOutputProtocol!
    
    var newsCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.fetchData()
        setup()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        layout()
    }
    
    // MARK:- Setup
    private func setup() {
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout.init()
        newsCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        newsCollectionView.backgroundColor = .white
        newsCollectionView.translatesAutoresizingMaskIntoConstraints = false
//        newsCollectionView.showsHorizontalScrollIndicator = false
        newsCollectionView.register(SuggestionViewCell.self, forCellWithReuseIdentifier: "SuggestionCell")
        newsCollectionView.delegate = self
        newsCollectionView.dataSource = self
        view.addSubview(newsCollectionView)
    }
    
    // MARK:- Layout
    private func layout() {
        layoutView()
        layoutCollectionView()
    }
    
    private func layoutView() {
        view.backgroundColor = .white
    }
    
    private func layoutCollectionView() {
        newsCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        newsCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        newsCollectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        newsCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
    }
}

extension ViewMain: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return suggestionStatic.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = newsCollectionView.dequeueReusableCell(withReuseIdentifier: "SuggestionCell", for: indexPath)
        let suggestion = suggestionStatic[indexPath.row]
        if let tmpCell = cell as? SuggestionViewCell {
            tmpCell.setup(suggestion: suggestion)
            tmpCell.layer.cornerRadius = 8
            tmpCell.clipsToBounds = true
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let approximateWidth = view.frame.width - 40 - 97 - 62 - 40
        let size = CGSize(width: approximateWidth, height: 1000)
        let attributes = [NSAttributedString.Key.font: UIFont(name:"HelveticaNeue", size: 16.0)]
        let estFrame = NSString(string: suggestionStatic[indexPath.row].description ?? "").boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributes as [NSAttributedString.Key : Any], context: nil)
        return CGSize(width: view.frame.width - 40, height: estFrame.height + 85)
    }
    
}

extension ViewMain: MainInputProtocol {
    func success() {
        
    }
    
    func failure() {
        
    }
}

