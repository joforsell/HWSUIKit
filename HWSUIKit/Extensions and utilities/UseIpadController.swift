//
//  UseIpadController.swift
//  HWSUIKit
//
//  Created by Johan Forsell on 2022-04-01.
//

import UIKit

class UseIpadController: UIViewController {
    @IBOutlet var iPadImage: UIImageView!
    @IBOutlet var useIpadLabel: UILabel!
    @IBOutlet var pushViewButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let configuration = UIImage.SymbolConfiguration(paletteColors: [UIColor.backgroundRed!, UIColor.backgroundRed!.withAlphaComponent(0.5)])
        iPadImage.image = UIImage(systemName: "apps.ipad.landscape", withConfiguration: configuration)
        
        useIpadLabel.text = "This project needs a lot of space. Please use iPad to view it properly."
        useIpadLabel.font = UIFont.boldSystemFont(ofSize: 20)
        useIpadLabel.numberOfLines = 2
        useIpadLabel.textAlignment = .center
        
        pushViewButton.tintColor = .backgroundRed
        pushViewButton.setTitle("I don't care, show me anyway!", for: .normal)
        pushViewButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
    }
    
    @IBAction func pushViewAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "Swifty Words")
        navigationController?.pushViewController(vc, animated: true)
    }
}
