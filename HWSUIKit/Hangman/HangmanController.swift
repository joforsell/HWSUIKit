//
//  HangmanController.swift
//  HWSUIKit
//
//  Created by Johan Forsell on 2022-04-04.
//

import UIKit

class HangmanController: UIViewController {
    
    let keyboardVC = KeyboardViewController()
    let boardVC = BoardViewController()
    let imageVC = ImageViewController()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemGray6
        addChildren()
    }
    
    private func addChildren() {
        addChild(imageVC)
        imageVC.didMove(toParent: self)
        imageVC.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageVC.view)
        
        addChild(boardVC)
        boardVC.didMove(toParent: self)
        boardVC.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(boardVC.view)
        
        addChild(keyboardVC)
        keyboardVC.didMove(toParent: self)
        keyboardVC.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(keyboardVC.view)

        addConstraints()
    }
    
    func addConstraints() {
        NSLayoutConstraint.activate([
            imageVC.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            imageVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageVC.view.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.45),
            
            boardVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            boardVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            boardVC.view.topAnchor.constraint(equalTo: imageVC.view.bottomAnchor),
            boardVC.view.bottomAnchor.constraint(equalTo: keyboardVC.view.topAnchor),
            boardVC.view.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1),
            
            keyboardVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            keyboardVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            keyboardVC.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
