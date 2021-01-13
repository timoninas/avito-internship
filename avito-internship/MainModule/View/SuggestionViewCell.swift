//
//  SuggestionViewCell.swift
//  avito-internship
//
//  Created by Антон Тимонин on 13.01.2021.
//

import UIKit

class SuggestionViewCell: UICollectionViewCell {
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
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutIfNeeded()
    }
    
    func setup(suggestion: Suggestion) {
        self.backgroundColor = #colorLiteral(red: 0.9725490196, green: 0.9725490196, blue: 0.9725490196, alpha: 1)
        
        addSubview(statusImageView)
        addSubview(isSelectedImageView)
        labelStackView.addArrangedSubview(titleLabel)
        labelStackView.addArrangedSubview(descriptionLabel)
        labelStackView.addArrangedSubview(priceLabel)
        addSubview(labelStackView)
        
        if let img = UIImage(named: "checkmark") {
            isSelectedImageView.image = img
        }
        
        // Fetch Image Data
        if let url = URL(string: suggestion.icon), let data = try? Data(contentsOf: url) {
            // Create Image and Update Image View
            statusImageView.image = UIImage(data: data)
        }
        
        titleLabel.text = suggestion.title
        descriptionLabel.text = suggestion.description
        priceLabel.text = suggestion.price
        
        layout()
    }
    
    private func layout() {
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
