//
//  WhiteHousePetitionsTabBarController.swift
//  HWSUIKit
//
//  Created by Johan Forsell on 2022-03-31.
//

import UIKit

class WhiteHousePetitionsTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Credits", style: .plain, target: self, action: #selector(showCredits))

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "White House Top Rated")
        vc.tabBarItem = UITabBarItem(tabBarSystemItem: .topRated, tag: 1)
        vc.tabBarItem.standardAppearance?.selectionIndicatorTintColor = .backgroundRed
        self.viewControllers?.append(vc)
        self.tabBar.tintColor = .backgroundRed
    }
    
    @objc
    func showCredits() {
        let ac = UIAlertController(title: "White House", message: "These petitions come directly from the folks at the White House", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
}
