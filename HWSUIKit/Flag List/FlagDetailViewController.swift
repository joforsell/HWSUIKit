//
//  FlagDetailViewController.swift
//  HWSUIKit
//
//  Created by Johan Forsell on 2022-02-21.
//

import UIKit

class FlagDetailViewController: UIViewController {
    @IBOutlet var flagImage: UIImageView!
    @IBOutlet var countryLabel: UILabel!
    
    var country: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareCountry))

        setup()
    }
    
    func setup() {
        flagImage.image = UIImage(named: country!)
        flagImage.layer.borderWidth = 1
        flagImage.layer.borderColor = UIColor.lightGray.cgColor
        flagImage.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        flagImage.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        flagImage.layer.shadowOpacity = 1.0
        flagImage.layer.shadowRadius = 2.0
        flagImage.layer.masksToBounds = false
        countryLabel.text = capitalizedCountry(country!)
    }
    
    func capitalizedCountry(_ country: String) -> String {
        if country.count == 2 {
            return country.uppercased()
        } else {
            return country.capitalized
        }
    }
    
    @objc
    func shareCountry() {
        guard let image = flagImage.image?.jpegData(compressionQuality: 0.8) else {
            print("Image not found")
            return
        }
        
        let vc = UIActivityViewController(activityItems: [image, capitalizedCountry(country!)], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
}
