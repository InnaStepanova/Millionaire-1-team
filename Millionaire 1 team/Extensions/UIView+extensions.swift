//
//  UIView+extensions.swift
//  Millionaire 1 team
//
//  Created by Konstantin Grachev on 06.02.2023.
//

import UIKit

extension UIView {

    func dropShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 10, height: 10)
        layer.shadowRadius = 10
    }
}
