//
//  ViewController.swift
//  avito-internship
//
//  Created by Антон Тимонин on 13.01.2021.
//

import UIKit


class ViewMain: UIViewController {
    var indexPath = IndexPath(item: -1, section: 0)
    
    var presenter: MainOutputProtocol!
    
    var newsCollectionView: UICollectionView!
    
    let cancelButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.isUserInteractionEnabled = true
        return btn
    }()
    
    let pickButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.cornerRadius = 8
        btn.backgroundColor = #colorLiteral(red: 0, green: 0.6784313725, blue: 1, alpha: 1)
        return btn
    }()
    
    let titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name:"Helvetica-Bold", size: 29.0)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.contentMode = .topLeft
        lbl.numberOfLines = 2
        lbl.adjustsFontSizeToFitWidth = true
        return lbl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        presenter.fetchData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        layout()
    }
    
    // MARK:- Setup
    private func setup() {
        setupButtons()
        setupLabels()
        setupCollectionView()
    }
    
    private func setupButtons() {
        cancelButton.setImage(UIImage(named: "CloseIconTemplate"), for: .normal)
        pickButton.setTitle("Выбрать", for: .normal)
        pickButton.setTitleColor(.white, for: .normal)
        pickButton.addTarget(self, action: #selector(pickButtonTapped(sender:)), for: .touchUpInside)
        
        view.addSubview(cancelButton)
        view.addSubview(pickButton)
    }
    
    private func setupLabels() {
        view.addSubview(titleLabel)
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout.init()
        newsCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        newsCollectionView.backgroundColor = .white
        newsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        newsCollectionView.showsVerticalScrollIndicator = false
        newsCollectionView.register(SuggestionViewCell.self, forCellWithReuseIdentifier: "SuggestionCell")
        newsCollectionView.delegate = self
        newsCollectionView.dataSource = self
        view.addSubview(newsCollectionView)
        
    }
    
    // MARK:- Layout
    private func layout() {
        layoutView()
        layoutButtons()
        layoutLabels()
        layoutCollectionView()
        view.bringSubviewToFront(pickButton)
    }
    
    private func layoutView() {
        view.backgroundColor = .white
    }
    
    private func layoutButtons() {
        cancelButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 25).isActive = true
        cancelButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15).isActive = true
        cancelButton.heightAnchor.constraint(equalToConstant: 35).isActive = true
        cancelButton.widthAnchor.constraint(equalTo: cancelButton.heightAnchor, multiplier: 1).isActive = true
        
        pickButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        pickButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        pickButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
        pickButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    private func layoutLabels() {
        titleLabel.topAnchor.constraint(equalTo: cancelButton.bottomAnchor, constant: 30).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 80).isActive = true
    }
    
    private func layoutCollectionView() {
        newsCollectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30).isActive = true
        newsCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        newsCollectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        newsCollectionView.bottomAnchor.constraint(equalTo: pickButton.topAnchor, constant: 5).isActive = true
    }
}

extension ViewMain: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let suggestions = presenter.getSuggestion() else { return 0 }
        return suggestions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = newsCollectionView.dequeueReusableCell(withReuseIdentifier: "SuggestionCell", for: indexPath)
        guard let suggestions = presenter.getSuggestion() else { return cell }
        let suggestion = suggestions[indexPath.item]
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
        guard let suggestions = presenter.getSuggestion() else { return CGSize(width: 0, height: 0) }
        let estFrame = NSString(string: suggestions[indexPath.item].listDescription ?? "").boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributes as [NSAttributedString.Key : Any], context: nil)
        return CGSize(width: view.frame.width - 40, height: estFrame.height + 85)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? SelectionProtocol {
            self.indexPath = indexPath
            cell.select()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? SelectionProtocol {
            cell.deselect()
        }
    }
    
    @objc
    func pickButtonTapped(sender: UIButton) {
        if let suggestions = presenter.getSuggestion(),
           self.indexPath.item <= suggestions.count {
            if self.indexPath.item >= 0 {
                presentAlert(title: "Вы выбрали опцию", message: suggestions[indexPath.item].title, actions: [UIAlertAction(title: "Ок", style: .default, handler: nil)])
            } else {
                presentAlert(title: "Вы не выбрали опцию", message: "", actions: [UIAlertAction(title: "Ок", style: .default, handler: nil)])
            }
        }
    }
}

extension ViewMain: MainInputProtocol {
    func success() {
        newsCollectionView.reloadData()
        if let title = presenter.getTitle() {
            titleLabel.text = title
        }
    }
    
    func failure() {
        
    }
    
    private func presentAlert(title: String, message: String, actions: [UIAlertAction]) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        actions.forEach { (action) in
            alert.addAction(action)
        }
        present(alert, animated: true, completion: nil)
    }
}

