//
//  EndGameViewController.swift
//  HWSUIKit
//
//  Created by Johan Forsell on 2022-04-06.
//

import UIKit

protocol EndGameViewControllerDelegate: AnyObject {
    func newGame()
}

class EndGameViewController: UIViewController {
    
    weak var delegate: EndGameViewControllerDelegate?
    
    let titleView: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints =  false
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .white
        return imageView
    }()
    
    let uiButton: UIButton = {
        let uiButton = UIButton()
        uiButton.translatesAutoresizingMaskIntoConstraints = false
        uiButton.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        uiButton.backgroundColor = .backgroundRed
        uiButton.layer.cornerRadius = 8
        return uiButton
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        titleView.font = .boldSystemFont(ofSize: view.frame.width / 8)
        view.backgroundColor = .black.withAlphaComponent(0.8)
        view.addSubview(titleView)
        view.addSubview(imageView)
        view.addSubview(uiButton)
        NSLayoutConstraint.activate([
            titleView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.frame.width / 4),
            titleView.bottomAnchor.constraint(equalTo: imageView.topAnchor, constant: -40),
            titleView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            imageView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            imageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            uiButton.widthAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 0.7),
            uiButton.heightAnchor.constraint(equalToConstant: view.frame.width / 6),
            uiButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            uiButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -(view.frame.width / 4))
        ])
    }
    
    @objc
    func dismissView() {
        UIView.animate(withDuration: 1, animations: { [weak self] in
            self?.view.alpha = 0
        }) { [weak self] finished in
            if finished {
                self?.view.isHidden = true
            }
        }
        delegate?.newGame()
    }
}
