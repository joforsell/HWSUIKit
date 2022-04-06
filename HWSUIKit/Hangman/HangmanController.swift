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
    let dotsVC = GuessCountController()
    let endGameVC = EndGameViewController()
    
    var words = ["street", "boolean", "sunset", "balloon", "cakeday", "reaper", "officer", "digest"]
    var answer = ""
    var guesses = [Character?]() {
        didSet {
            for char in Array(answer) {
                if !guesses.contains(char) {
                    return
                }
            }
            endGameVC.titleView.text = "YOU WON!"
            endGameVC.imageView.image = UIImage(named: "trophy.png")
            endGameVC.uiButton.setTitle("New game", for: .normal)
            endGameVC.view.isHidden = false
            UIView.animate(withDuration: 1) { [weak self] in
                self?.endGameVC.view.alpha = 1
            }
        }
    }
    var guessAmount = 0 {
        didSet {
            for (index, view) in dotsVC.stackView.arrangedSubviews.enumerated() {
                view.backgroundColor = index + 1 > guessAmount ? .systemGray : .systemRed
            }
            if guessAmount > 6 {
                endGameVC.titleView.text = "YOU LOST"
                endGameVC.imageView.image = UIImage(named: "skull.png")
                endGameVC.uiButton.setTitle("Try again", for: .normal)
                endGameVC.view.isHidden = false
                UIView.animate(withDuration: 1) { [weak self] in
                    self?.endGameVC.view.alpha = 1
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(newGame))

        view.backgroundColor = .systemGray6
        answer = words.randomElement() ?? "sunset"
        addChildren()
    }
    
    private func addChildren() {
        addChild(imageVC)
        imageVC.didMove(toParent: self)
        imageVC.view.translatesAutoresizingMaskIntoConstraints = false
        imageVC.view.clipsToBounds = true
        view.addSubview(imageVC.view)
        
        addChild(dotsVC)
        dotsVC.didMove(toParent: self)
        dotsVC.view.translatesAutoresizingMaskIntoConstraints = false
        dotsVC.dataSource = self
        view.addSubview(dotsVC.view)
        
        addChild(boardVC)
        boardVC.didMove(toParent: self)
        boardVC.view.translatesAutoresizingMaskIntoConstraints = false
        boardVC.dataSource = self
        view.addSubview(boardVC.view)
        
        addChild(keyboardVC)
        keyboardVC.didMove(toParent: self)
        keyboardVC.view.translatesAutoresizingMaskIntoConstraints = false
        keyboardVC.delegate = self
        keyboardVC.dataSource = self
        view.addSubview(keyboardVC.view)
        
        addChild(endGameVC)
        endGameVC.didMove(toParent: self)
        endGameVC.view.translatesAutoresizingMaskIntoConstraints = false
        endGameVC.view.isHidden = true
        endGameVC.view.alpha = 0
        endGameVC.delegate = self
        view.addSubview(endGameVC.view)

        addConstraints()
    }
    
    func addConstraints() {
        NSLayoutConstraint.activate([
            endGameVC.view.topAnchor.constraint(equalTo: view.topAnchor),
            endGameVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            endGameVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            endGameVC.view.heightAnchor.constraint(equalTo: view.heightAnchor),
            
            imageVC.view.topAnchor.constraint(equalTo: view.topAnchor),
            imageVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageVC.view.heightAnchor.constraint(equalTo: view.heightAnchor),
            
            dotsVC.view.bottomAnchor.constraint(equalTo: boardVC.view.topAnchor, constant: -20),
            dotsVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dotsVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            dotsVC.view.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1),
            
            boardVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            boardVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            boardVC.view.bottomAnchor.constraint(equalTo: keyboardVC.view.topAnchor),
            boardVC.view.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.15),
            
            keyboardVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            keyboardVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            keyboardVC.view.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3),
            keyboardVC.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension HangmanController: KeyboardViewControllerDelegate, EndGameViewControllerDelegate, GameDataSource {
    
    func didTapKey(with letter: Character) {
        guesses.append(letter)
        let indexedAnswer = Array(answer)
        if !indexedAnswer.contains(letter) {
            guessAmount += 1
        }
        
        boardVC.reloadData()
    }
    
    var currentGuesses: [Character?] {
        return guesses
    }
    
    var wrongGuesses: Int {
        return guessAmount
    }
    
    var correctAnswer: [Character?] {
        return Array(answer)
    }
    
    func isLetterHidden(at indexPath: IndexPath) -> Bool {
        let indexedAnswer = Array(answer)
        return !guesses.contains(indexedAnswer[indexPath.row])
    }
    
    @objc
    func newGame() {
        guesses = []
        guessAmount = 0
        answer = words.randomElement() ?? "sunset"
        boardVC.reloadData()
        keyboardVC.reloadData()
    }
}
