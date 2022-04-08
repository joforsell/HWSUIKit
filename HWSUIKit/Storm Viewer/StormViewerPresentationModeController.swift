//
//  StormViewerPresentationModeController.swift
//  HWSUIKit
//
//  Created by Johan Forsell on 2022-04-08.
//

import UIKit

class StormViewerPresentationModeController: UIViewController {
    
    let collectionViewButton: UIButton = {
        let button = UIButton()
        let configuration = UIImage.SymbolConfiguration(paletteColors: [UIColor.backgroundRed!, UIColor.backgroundRed!.withAlphaComponent(0.5)])
        let sizeConfiguration = UIImage.SymbolConfiguration(font: .boldSystemFont(ofSize: 200))
        let image = UIImage(systemName: "square.grid.4x3.fill", withConfiguration: configuration)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(image?.applyingSymbolConfiguration(sizeConfiguration), for: .normal)
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.backgroundRed?.cgColor
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(pushCollectionVC), for: .touchUpInside)
        return button
    }()
    
    let tableViewButton: UIButton = {
        let button = UIButton()
        let configuration = UIImage.SymbolConfiguration(paletteColors: [UIColor.backgroundRed!, UIColor.backgroundRed!.withAlphaComponent(0.5)])
        let sizeConfiguration = UIImage.SymbolConfiguration(font: .boldSystemFont(ofSize: 200))
        let image = UIImage(systemName: "list.dash", withConfiguration: configuration)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.imageView?.contentMode = .scaleAspectFit
        button.setImage(image?.applyingSymbolConfiguration(sizeConfiguration), for: .normal)
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.backgroundRed?.cgColor
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(pushTableVC), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Choose format"
        view.addSubview(collectionViewButton)
        view.addSubview(tableViewButton)
        
        NSLayoutConstraint.activate([
            collectionViewButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            collectionViewButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -(min(view.frame.height, view.frame.width) / 5)),
            collectionViewButton.widthAnchor.constraint(equalToConstant: min(view.frame.width, view.frame.height) * 0.5),
            collectionViewButton.heightAnchor.constraint(equalTo: collectionViewButton.widthAnchor, multiplier: 0.6),
            
            tableViewButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tableViewButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: min(view.frame.height, view.frame.width) / 5),
            tableViewButton.widthAnchor.constraint(equalToConstant: min(view.frame.width, view.frame.height) * 0.5),
            tableViewButton.heightAnchor.constraint(equalTo: tableViewButton.widthAnchor, multiplier: 0.6)
        ])
    }
    
    @objc
    func pushTableVC() {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Table Storm Viewer") {
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc
    func pushCollectionVC() {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Collection Storm Viewer") {
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
