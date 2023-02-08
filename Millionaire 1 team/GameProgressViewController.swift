//
//  GameProgressViewController.swift
//  Millionaire 1 team
//
//  Created by Лаванда on 06.02.2023.
//

import UIKit

struct PrizeTable {
    var qwestionNumber: Int
    var winningSumm: Int
    var color: ColorImage
}

extension PrizeTable {
    static func getPrizeTable() -> [PrizeTable] {
        [PrizeTable(qwestionNumber: 15, winningSumm: 1000000, color: .gold),
         PrizeTable(qwestionNumber: 14, winningSumm: 500000, color: .purple),
         PrizeTable(qwestionNumber: 13, winningSumm: 250000, color: .purple),
         PrizeTable(qwestionNumber: 12, winningSumm: 125000, color: .purple),
         PrizeTable(qwestionNumber: 11, winningSumm: 64000, color: .purple),
         PrizeTable(qwestionNumber: 10, winningSumm: 32000, color: .blue),
         PrizeTable(qwestionNumber: 9, winningSumm: 16000, color: .purple),
         PrizeTable(qwestionNumber: 8, winningSumm: 8000, color: .purple),
         PrizeTable(qwestionNumber: 7, winningSumm: 4000, color: .purple),
         PrizeTable(qwestionNumber: 6, winningSumm: 2000, color: .purple),
         PrizeTable(qwestionNumber: 5, winningSumm: 1000, color: .blue),
         PrizeTable(qwestionNumber: 4, winningSumm: 500, color: .purple),
         PrizeTable(qwestionNumber: 3, winningSumm: 300, color: .purple),
         PrizeTable(qwestionNumber: 2, winningSumm: 200, color: .purple),
         PrizeTable(qwestionNumber: 1, winningSumm: 100, color: .green)
        ]
    }
}

class GameProgressViewController: UIViewController {
    
    private var currentQuestion = 1
    private var prizeTable = PrizeTable.getPrizeTable()
    
    private let millionaireImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Resourses.Images.millioneireImage
        return imageView
    }()
    
    private let nextQuestinButton: UIButton = {
        let button = UIButton()
        button.setTitle("Next Question", for: .normal)
        button.layer.cornerRadius = 20
        button.backgroundColor = .blue
        return button
    }()
    
    private let takeMoneyButton: UIButton = {
        let button = UIButton()
        button.setTitle("Take My Money", for: .normal)
        button.layer.cornerRadius = 20
        button.backgroundColor = .red
        return button
    }()
    
    private var progressImageStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 5
        stack.distribution = .fillEqually
        return stack
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let backGroundImage = UIImageView(frame: UIScreen.main.bounds)
        backGroundImage.image = Resourses.Images.bacgroundImage
        backGroundImage.contentMode = .scaleAspectFill
        view.insertSubview(backGroundImage, at: 0)
        
        addViews()
        getStackView()
        layoutViews()
    }
}

private extension GameProgressViewController {
    
    func addViews() {
        view.addSubview(millionaireImage)
        view.addSubview(nextQuestinButton)
        view.addSubview(takeMoneyButton)
        view.addSubview(progressImageStackView)
        
    }
    
    func layoutViews() {
        millionaireImage.translatesAutoresizingMaskIntoConstraints = false
        nextQuestinButton.translatesAutoresizingMaskIntoConstraints = false
        takeMoneyButton.translatesAutoresizingMaskIntoConstraints = false
        progressImageStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            takeMoneyButton.heightAnchor.constraint(equalToConstant: 40),
            takeMoneyButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            takeMoneyButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            
            nextQuestinButton.heightAnchor.constraint(equalToConstant: 40),
            nextQuestinButton.leadingAnchor.constraint(equalTo: takeMoneyButton.trailingAnchor, constant: 20),
            nextQuestinButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            nextQuestinButton.bottomAnchor.constraint(equalTo: takeMoneyButton.bottomAnchor),
            nextQuestinButton.widthAnchor.constraint(equalTo: takeMoneyButton.widthAnchor),
            
            millionaireImage.heightAnchor.constraint(equalToConstant: 100),
            millionaireImage.widthAnchor.constraint(equalToConstant: 100),
            millionaireImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            millionaireImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            progressImageStackView.topAnchor.constraint(equalTo: millionaireImage.bottomAnchor, constant: 15),
            progressImageStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            progressImageStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            progressImageStackView.bottomAnchor.constraint(equalTo: nextQuestinButton.topAnchor, constant: -20)
        ])
    }
    
    private func getStackView() {
        for prize in prizeTable {
            let questionImage = ProgressImage(questionNumber: "Вопрос \(prize.qwestionNumber)", winningSumm: "\(prize.winningSumm) RUB", colorImage: prize.color)
            progressImageStackView.addArrangedSubview(questionImage)
        }
    }
}
