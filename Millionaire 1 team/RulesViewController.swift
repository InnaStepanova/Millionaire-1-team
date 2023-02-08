//
//  RulesViewController.swift
//  Millionaire 1 team
//
//  Created by Дмитрий on 06.02.2023.
//

import UIKit

class RulesViewController: UIViewController {
    
    let backgroundView: UIImageView = {
            let myView = UIImageView()
            let image = UIImage(named: "Frame")
            myView.image = image
            myView.contentMode = .scaleToFill
            myView.translatesAutoresizingMaskIntoConstraints = false
            return myView
        }()
    
    let rulesTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = .systemFont(ofSize: 20)
        textView.textColor = .white
        textView.autocapitalizationType = .allCharacters
        textView.text = rulesText
        textView.textAlignment = .justified
        textView.backgroundColor = .clear
        return textView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(backgroundView)
        view.addSubview(rulesTextView)
        setupRulesTextView()
        setupBackgroundView()
    }
    
    func setupBackgroundView() {
        backgroundView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        backgroundView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        backgroundView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
    
    func setupRulesTextView() {
        rulesTextView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        rulesTextView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        rulesTextView.topAnchor.constraint(equalTo: view.topAnchor, constant: 90).isActive = true
        rulesTextView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40).isActive = true
    }
    
}

