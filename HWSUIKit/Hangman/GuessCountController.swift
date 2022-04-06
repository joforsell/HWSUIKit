//
//  GuessCountController.swift
//  HWSUIKit
//
//  Created by Johan Forsell on 2022-04-06.
//

import UIKit

class GuessCountController: UIViewController {
        
    weak var dataSource: GameDataSource?
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        for view in (0..<7) {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.backgroundColor = .systemGray
            view.layer.borderWidth = 1
            view.layer.borderColor = UIColor.backgroundRed?.cgColor
            view.heightAnchor.constraint(equalToConstant: 40).isActive = true
            view.widthAnchor.constraint(equalToConstant: 20).isActive = true
            stackView.addArrangedSubview(view)
        }
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 4
        stackView.alignment = .center
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.backgroundColor = .clear
        return stackView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width / 6),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -(view.frame.width / 6)),
            stackView.topAnchor.constraint(equalTo: view.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
