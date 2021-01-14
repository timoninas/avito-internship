//
//  SuggestionViewCell.swift
//  avito-internship
//
//  Created by Антон Тимонин on 13.01.2021.
//

import UIKit

protocol SelectionProtocol: class {
    func select()
    func deselect()
}

class SuggestionViewCell: UICollectionViewCell {
    var isSelect: Bool = false
    var suggestion: List!
    
    var statusImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        
        return iv
    }()
    
    var isSelectedImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        
        return iv
    }()
    
    var titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name:"Helvetica-Bold", size: 23.0)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.contentMode = .topLeft
        lbl.numberOfLines = 2
        lbl.adjustsFontSizeToFitWidth = true
        
        return lbl
    }()
    
    var descriptionLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name:"HelveticaNeue", size: 16.0)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.contentMode = .topLeft
        lbl.numberOfLines = 0
        
        return lbl
    }()
    
    var priceLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name:"HelveticaNeue-Bold", size: 19.0)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.contentMode = .topLeft
        lbl.numberOfLines = 1
        
        return lbl
    }()
    
    var labelStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = 0
        sv.distribution = .fill
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        isSelect == true ? select(): deselect()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutIfNeeded()
        addSubview(statusImageView)
        addSubview(isSelectedImageView)
        labelStackView.addArrangedSubview(titleLabel)
        labelStackView.addArrangedSubview(descriptionLabel)
        labelStackView.addArrangedSubview(priceLabel)
        addSubview(labelStackView)
        layout()
    }
    
    func setup(suggestion: List) {
        // Fetch Image Data
        DispatchQueue.global(qos: .userInitiated).async {
            if let url = URL(string: suggestion.icon.the52X52), let data = try? Data(contentsOf: url) {
                DispatchQueue.main.async {
                    self.statusImageView.image = UIImage(data: data)
                }
            }
        }
        
        titleLabel.text = suggestion.title
        descriptionLabel.attributedText = suggestion.listDescription?.lineSpaced(5)
        descriptionLabel.text = suggestion.listDescription
        priceLabel.text = suggestion.price
    }
    
    
    private func layout() {
        self.backgroundColor = #colorLiteral(red: 0.9725490196, green: 0.9725490196, blue: 0.9725490196, alpha: 1)
        layoutImageView()
        layoutLabels()
    }
    
    private func layoutImageView() {
        statusImageView.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
        statusImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 20).isActive = true
        statusImageView.widthAnchor.constraint(equalToConstant: 57).isActive = true
        statusImageView.heightAnchor.constraint(equalToConstant: 57).isActive = true
        
        isSelectedImageView.centerYAnchor.constraint(equalTo: statusImageView.centerYAnchor).isActive = true
        isSelectedImageView.rightAnchor.constraint(equalTo: rightAnchor, constant: -20).isActive = true
        isSelectedImageView.widthAnchor.constraint(equalToConstant: 22).isActive = true
        isSelectedImageView.heightAnchor.constraint(equalToConstant: 22).isActive = true
    }
    
    private func layoutLabels() {
        labelStackView.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
        labelStackView.leftAnchor.constraint(equalTo: statusImageView.rightAnchor, constant: 15).isActive = true
        labelStackView.rightAnchor.constraint(equalTo: isSelectedImageView.leftAnchor, constant: -10).isActive = true
        labelStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15).isActive = true
        
        titleLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        priceLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
}

extension SuggestionViewCell: SelectionProtocol {
    func select() {
        if let img = UIImage(named: "checkmark") {
            isSelectedImageView.image = img
            isSelect = true
        }
    }
    
    func deselect() {
        isSelectedImageView.image = UIImage()
        isSelect = false
    }
}
