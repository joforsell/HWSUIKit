//
//  ImageViewController.swift
//  HWSUIKit
//
//  Created by Johan Forsell on 2022-04-04.
//

import UIKit

class ImageViewController: UIViewController {
    
    let image: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "noose.jpg"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(image)
        NSLayoutConstraint.activate([
            image.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            image.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            image.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
