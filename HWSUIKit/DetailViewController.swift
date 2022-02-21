//
//  DetailViewController.swift
//  HWSUIKit
//
//  Created by Johan Forsell on 2022-02-14.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet var imageView: UIImageView!
    var selectedImage: String?
    var numberOfImages = 0
    var numberOfCurrentImage = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Picture \(numberOfCurrentImage) of \(numberOfImages)"
        navigationItem.largeTitleDisplayMode = .never

        if let imageToLoad = selectedImage {
            imageView.image = UIImage(named: imageToLoad)
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }
}
