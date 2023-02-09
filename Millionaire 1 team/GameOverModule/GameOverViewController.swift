//
//  GameOverViewController.swift
//  Millionaire 1 team
//
//  Created by Konstantin Grachev on 08.02.2023.
//

import UIKit

protocol GameOverViewControllerDelegate: AnyObject {
    func restartGame(isGameOver: Bool)
}

final class GameOverViewController: UIViewController {
    
    weak var delegate: GameOverViewControllerDelegate?
    
    private enum Constants {
        static let standartTrailingIndentation: CGFloat = -20
        static let standartLeadingIndentation: CGFloat = 20
        static let stackViewSpacing: CGFloat = 20
        static let stackViewHeight: CGFloat = 100
        static let logoInmageViewLeadindIndetation: CGFloat = 100
        static let logoInmageViewTrailingIndetation: CGFloat = -100
        
        static let textColor: UIColor = .white
    }
        
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = Constants.textColor
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private lazy var restartButton: GradientButton  = {
        let button = GradientButton(type: .system)
        button.setTitle("Новая игра", for: .normal)
        button.tintColor = Constants.textColor
        button.addTarget(self, action: #selector(restartButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private let backgroundImageView = UIImageView(image: Resourses.Images.bacgroundImage)
    
    private let logoImageView = {
        let imageView = UIImageView(image: Resourses.Images.millioneireImage)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    @objc private func restartButtonPressed() {
        delegate?.restartGame(isGameOver: false)
        dismiss(animated: true)
    }
    
    private func setupUI() {
        
        titleLabel.text = """
Игра только началась
и уже окончена.
Попробуй еще раз.
"""
        
        UIView.animate(withDuration: 0.3, delay: 0.1, options: [.repeat, .autoreverse]) {
            self.logoImageView.alpha = 0.8
        }
        
        let subviews = [backgroundImageView,
                        titleLabel,
                        restartButton,
                        logoImageView
        ]
        
        subviews.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            restartButton.heightAnchor.constraint(equalToConstant: Constants.stackViewHeight),
            restartButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.standartLeadingIndentation),
            restartButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constants.standartTrailingIndentation),
            restartButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            logoImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.logoInmageViewLeadindIndetation),
            logoImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constants.standartTrailingIndentation)
        ])
    }
}
