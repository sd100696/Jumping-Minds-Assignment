//
//  Helpers.swift
//  Assignment
//
//  Created by Sudhanshu Dwivedi on 05/07/23.
//

import Foundation
import UIKit

extension NSMutableAttributedString {
    func addBoldText(_ text: String, fontSize: CGFloat) {
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.boldSystemFont(ofSize: fontSize)
        ]
        let range = (string as NSString).range(of: text)
        addAttributes(attributes, range: range)
    }
    
    func addRegularText(_ text: String, fontSize: CGFloat) {
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: fontSize)
        ]
        let range = (string as NSString).range(of: text)
        addAttributes(attributes, range: range)
    }
}
