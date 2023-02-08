

import UIKit

@available(iOS 14.0, *)
class MainViewController: UIViewController {
    
    let backgroundView: UIImageView = {
        let background = UIImageView()
        background.image = UIImage(named: "Frame")
        background.translatesAutoresizingMaskIntoConstraints = false
        return background
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "The Game"
        label.textColor = .yellow
        label.font = UIFont(name: "Avenir Next Bold", size: 30)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Logomainview")
        
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = "welcome"
        label.textColor = .white
        label.font = UIFont(name: "Avenir Next", size: 30)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "to Who Wants to be a Millionare"
        label.textColor = .white
        label.font = UIFont(name: "Avenir Next Bold", size: 40)
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.numberOfLines = 2
        label.minimumScaleFactor = 0.5
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var rulesButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Rules of the Game", for: .normal)
        button.tintColor = #colorLiteral(red: 0.4352941176, green: 0.9294117647, blue: 0.8392156863, alpha: 1)
        //        button.backgroundColor = #colorLiteral(red: 0, green: 0.9914394021, blue: 1, alpha: 1)
        button.titleLabel?.font = UIFont(name: "Avenir Next Bold", size: 35)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        return button
    }()
    
    lazy var startButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Start", for: .normal)
        button.tintColor = #colorLiteral(red: 1, green: 0.5843137255, blue: 0.3176470588, alpha: 1)
        button.backgroundColor = #colorLiteral(red: 0.7254901961, green: 1, blue: 0.9725490196, alpha: 1)
        button.layer.cornerRadius = 10
        button.titleLabel?.font = UIFont(name: "Avenir Next Bold", size: 50)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(startGame), for: .touchUpInside)
        return button
    }()
    
    @objc private func startGame() {
        let rootVC = GameViewController()
        let navVC = UINavigationController(rootViewController: rootVC)
        navVC.modalPresentationStyle = .fullScreen
        present(navVC, animated: true)
    }
    
    @objc private func didTapButton() {
        let rootVC = RulesViewController()
        rootVC.navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "< Back", style: .plain, target: self, action: #selector(dismissSelf)
        )

        rootVC.navigationItem.leftBarButtonItem?.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.yellow, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 30.0)], for: .normal)
        
        
        let navVC = UINavigationController(rootViewController: rootVC)
        navVC.modalPresentationStyle = .fullScreen
        present(navVC, animated: true)
    }
    
    @objc private func dismissSelf() {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setConstraints()
    }
    

    
    func setupView() {
        view.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        view.addSubview(backgroundView)
        view.addSubview(titleLabel)
        view.addSubview(logoImageView)
        view.addSubview(nameLabel)
        view.addSubview(welcomeLabel)
        view.addSubview(rulesButton)
        view.addSubview(startButton)
    }
    
}

@available(iOS 14.0, *)
extension MainViewController {
    
    func setConstraints() {
        
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            logoImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            logoImageView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            
            welcomeLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 10),
            welcomeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 10),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            rulesButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            rulesButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            rulesButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            rulesButton.heightAnchor.constraint(equalToConstant: 60),
            
            startButton.bottomAnchor.constraint(equalTo: rulesButton.bottomAnchor, constant: -80),
            startButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 60),
            startButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -60),
            startButton.heightAnchor.constraint(equalToConstant: 60),
            
        ])
    }
}
