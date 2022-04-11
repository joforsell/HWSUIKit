//
//  PictureViewController.swift
//  HWSUIKit
//
//  Created by Johan Forsell on 2022-04-11.
//

import UIKit

class PictureViewController: UIViewController {
    
    var picture: String?
    
    var imageView: UIImageView
    
    init(imageView: UIImageView) {
        self.imageView = imageView
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let imageToLoad = picture {
            imageView.image = UIImage(named: imageToLoad)
        }

        view.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}
