//
//  ViewController.swift
//  TaskyApp
//
//  Created by Thayanne Mendes on 08/10/24.
//

import UIKit

class HomeViewController: UIViewController {
    
    private lazy var logoImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: AssestsConstants.logo))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var mainIlustrationImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: AssestsConstants.homeIlustrator))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var getReadyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text =  "Prepare-se para começar o dia, uma lista de cada vez. "
        label.textColor = UIColor(named: AssestsConstants.darkPurple)
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var getStartButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Vamos começar!", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        button.backgroundColor = UIColor(named: AssestsConstants.darkPurple)
        button.layer.cornerRadius = 12
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(didTapGetStartedButton), for: .touchUpInside)
        return button
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addBackgroundGradient()
        addSubviews()
        setupConstraints()
    }
    @objc func didTapGetStartedButton (){
        navigationController?.pushViewController(TasksViewController(), animated: true)
    }
    
    private func addSubviews(){
        view.addSubview(logoImageView)
        view.addSubview(mainIlustrationImageView)
        view.addSubview(getReadyLabel)
        view.addSubview(getStartButton)
        
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            mainIlustrationImageView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 8),
            mainIlustrationImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            getReadyLabel.topAnchor.constraint(equalTo: mainIlustrationImageView.bottomAnchor, constant: 32),
            getReadyLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 26),
            getReadyLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -26),
            
            getStartButton.topAnchor.constraint(equalTo: getReadyLabel.bottomAnchor, constant: 32),
            getStartButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            getStartButton.widthAnchor.constraint(equalToConstant: 162),
            getStartButton.heightAnchor.constraint(equalToConstant: 44)
            
            
            
        ])
    }


}

