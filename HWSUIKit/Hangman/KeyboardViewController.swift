//
//  KeyboardViewController.swift
//  HWSUIKit
//
//  Created by Johan Forsell on 2022-04-04.
//

import UIKit

protocol KeyboardViewControllerDelegate: AnyObject {
    func didTapKey(with letter: Character)
}

protocol GameDataSource: AnyObject {
    var currentGuesses: [Character?] { get }
    var correctAnswer: [Character?] { get }
    var wrongGuesses: Int { get }
    func isLetterHidden(at indexPath: IndexPath) -> Bool
}

class KeyboardViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    
    weak var delegate: KeyboardViewControllerDelegate?
    weak var dataSource: GameDataSource?
    
    let letters = ["qwertyuiop", "asdfghjkl", "zxcvbnm"]
    private var keys = [[Character]]()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 2
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(KeyCell.self, forCellWithReuseIdentifier: KeyCell.identifier)
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.backgroundColor = .clear
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        for row in letters {
            let chars = Array(row)
            keys.append(chars)
        }
    }
    
    public func reloadData() {
        collectionView.reloadData()
    }
}

extension KeyboardViewController {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return keys.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return keys[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KeyCell.identifier, for: indexPath) as? KeyCell else {
            fatalError()
        }
        let letter = keys[indexPath.section][indexPath.row]
        cell.configure(with: letter)
        cell.backgroundColor = setBackgroundColor(for: letter)
        cell.label.isHidden = hideLetter(letter)
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.systemGray3.cgColor
        return cell
    }
    
    func setBackgroundColor(for letter: Character) -> UIColor? {
        guard let dataSource = dataSource else { return nil }
        
        if dataSource.currentGuesses.contains(letter) && dataSource.correctAnswer.contains(letter) {
            return .systemGreen
        } else if dataSource.currentGuesses.contains(letter) {
            return .systemRed
        } else {
            return .systemGray
        }
    }
    
    func hideLetter(_ letter: Character) -> Bool {
        guard let dataSource = dataSource else { return true }
        
        return dataSource.currentGuesses.contains(letter) && !dataSource.correctAnswer.contains(letter)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let margin: CGFloat = 20
        let size: CGFloat = (collectionView.frame.size.width-margin)/10
        
        return CGSize(width: size, height: size*1.2)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        var left: CGFloat = 1
        var right: CGFloat = 1
        
        let margin: CGFloat = 20
        let size: CGFloat = (collectionView.frame.size.width-margin)/10
        let count: CGFloat = CGFloat(collectionView.numberOfItems(inSection: section))
        
        let inset: CGFloat = (collectionView.frame.size.width - (size * count) - (2 * count))/2
        
        left = inset
        right = inset
        
        return UIEdgeInsets(top: 2,
                            left: left,
                            bottom: 2,
                            right: right
        )
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let letter = keys[indexPath.section][indexPath.row]
        delegate?.didTapKey(with: letter)
        collectionView.reloadData()
    }
}
