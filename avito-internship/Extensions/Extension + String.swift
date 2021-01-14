//
//  Extension + String.swift
//  avito-internship
//
//  Created by Антон Тимонин on 14.01.2021.
//

import UIKit

extension String {
    func lineSpaced(_ spacing: CGFloat) -> NSAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = spacing
        let attributedString = NSAttributedString(string: self, attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        return attributedString
    }
}
