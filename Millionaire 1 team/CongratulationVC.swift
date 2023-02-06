//
//  CongratulationVC.swift
//  Millionaire 1 team
//
//  Created by Артём Голынец on 6.02.23.
//

import UIKit

class CongratulationVC : UIViewController {
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
        label.text = "Поздравляю, вы выиграли\n1 000 000!"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont(name: "DIN Condensed", size: 40)
        label.textColor = UIColor(red: 255/255, green: 215/255, blue: 0/255, alpha: 1)
        label.numberOfLines = 0
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(backgroundView)
        view.addSubview(congratulationLabel)
        setupUI()
    }
    
    func setupUI() {
        backgroundView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        backgroundView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        backgroundView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        congratulationLabel.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        congratulationLabel.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        congratulationLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        congratulationLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    func changeAmount(_ amount: String) {
        congratulationLabel.text = "Поздравляю, вы выиграли\n\(amount)!"
    }
    
}
