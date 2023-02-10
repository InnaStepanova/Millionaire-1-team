//
//  GradientView.swift
//  Millionaire 1 team
//
//  Created by Konstantin Grachev on 09.02.2023.
//

import UIKit

class GradientView: UIView {
    
    private enum Constants {
        static let cornerRadius: CGFloat = 10
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        dropShadow()
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }
    
    lazy var gradientLayer: CAGradientLayer = {
        let gradientLayer = CAGradientLayer()
        gradientLayer.borderColor = UIColor.gray.cgColor
        gradientLayer.borderWidth = 1
        let colors: [UIColor] = [#colorLiteral(red: 0.2530327737, green: 0.4159591794, blue: 0.5364745855, alpha: 1), #colorLiteral(red: 0.1300314665, green: 0.2300171852, blue: 0.3798839748, alpha: 1), #colorLiteral(red: 0.2530327737, green: 0.4159591794, blue: 0.5364745855, alpha: 1)]
        gradientLayer.colors = colors.map { $0.cgColor }
        gradientLayer.startPoint = CGPoint(x: 0, y: 1)
        gradientLayer.endPoint = CGPoint(x: 0, y: 0)
        gradientLayer.cornerRadius = Constants.cornerRadius
        layer.insertSublayer(gradientLayer, at: 0)
        return gradientLayer
    }()
    
    private func setupUI() {
        layer.cornerRadius = Constants.cornerRadius
    }
}
