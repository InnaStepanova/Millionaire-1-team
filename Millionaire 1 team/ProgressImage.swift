//
//  ProgressImage.swift
//  Millionaire 1 team
//
//  Created by Лаванда on 06.02.2023.
//

import UIKit

enum ColorImage: String {
    case red = "red"
    case green = "green"
    case blue = "blue"
    case purple = "purple"
    case gold = "gold"
}

class ProgressImage: UIView {
    
    private let questionNumber: UILabel = {
        let label = UILabel()
        label.textColor = .white
        return label
    }()
    
    private let winningSumm: UILabel = {
        let label = UILabel()
        label.textColor = .white
        return label
    }()
    
    private let contentImage: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        addViews()
//        layoutViews()
//    }
    
    init(questionNumber: String, winningSumm: String, colorImage: ColorImage ) {
        self.questionNumber.text = questionNumber
        self.winningSumm.text = winningSumm
//        let image = UIImage(named: colorImage.rawValue)
        self.contentImage.image = UIImage(named: colorImage.rawValue)
        super.init(frame: .zero)
        self.addViews()
        self.layoutViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
    

extension ProgressImage {
    private func addViews() {
        addSubview(contentImage)
        addSubview(questionNumber)
        addSubview(winningSumm)
    }
    
    private func layoutViews() {
        questionNumber.translatesAutoresizingMaskIntoConstraints = false
        winningSumm.translatesAutoresizingMaskIntoConstraints = false
        contentImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contentImage.topAnchor.constraint(equalTo: topAnchor),
            contentImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentImage.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            questionNumber.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            questionNumber.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            winningSumm.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            winningSumm.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
}
