//
//  CongratulationVC.swift
//  Millionaire 1 team
//
//  Created by Артём Голынец on 6.02.23.
//

import UIKit

protocol CongratulationVCDelegate: AnyObject {
    func restartFromCongrats(dismiss: Void)
}

class CongratulationVC : UIViewController {
    
    weak var delegate: CongratulationVCDelegate?
    
    let backgroundView: UIImageView = {
            let myView = UIImageView()
            let image = UIImage(named: "Frame")
            myView.image = image
            myView.contentMode = .scaleToFill
            myView.translatesAutoresizingMaskIntoConstraints = false
            return myView
        }()
    
    let congratulationLabel : UILabel = {
       let label = UILabel()
        label.text = "Поздравляю, вы выиграли\n1 000 000 рублей!"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont(name: "DIN Condensed", size: 40)
        label.textColor = UIColor(red: 255/255, green: 215/255, blue: 0/255, alpha: 1)
        label.numberOfLines = 0
        return label
    }()
    
    private let millionaireImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Resourses.Images.millioneireImage
        return imageView
    }()
    
    private lazy var newGameButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("New Game", for: .normal)
        button.layer.cornerRadius = 20
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir Next Bold", size: 30)
        button.backgroundColor = .blue
        button.addTarget(self, action: #selector(newGameButtonPressed), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(backgroundView)
        view.addSubview(congratulationLabel)
        view.addSubview(millionaireImage)
        view.addSubview(newGameButton)
        setupUI()
    }
    
    func setupUI() {
        
        millionaireImage.translatesAutoresizingMaskIntoConstraints = false
        newGameButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            millionaireImage.heightAnchor.constraint(equalToConstant: 200),
            millionaireImage.widthAnchor.constraint(equalToConstant: 200),
            millionaireImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            millionaireImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            congratulationLabel.topAnchor.constraint(equalTo: millionaireImage.bottomAnchor, constant: 50),
            congratulationLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            newGameButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            newGameButton.heightAnchor.constraint(equalToConstant: 75),
            newGameButton.widthAnchor.constraint(equalToConstant: 250),
            newGameButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    func changeAmount(_ amount: String) {
        congratulationLabel.text = "Поздравляю, вы выиграли\n\(amount) рублей!"
        
    }
    
    @objc private func newGameButtonPressed() {
            self.delegate?.restartFromCongrats(dismiss: self.dismiss(animated: false))
            self.dismiss(animated: false)
            
        
    }
}
