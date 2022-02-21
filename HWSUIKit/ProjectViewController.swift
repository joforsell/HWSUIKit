//
//  ProjectViewController.swift
//  HWSUIKit
//
//  Created by Johan Forsell on 2022-02-15.
//

import UIKit

class ProjectViewController: UIViewController {
    @IBOutlet var projectTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
                
        projectTableView.delegate = self
        projectTableView.dataSource = self
        projectTableView.backgroundColor = .clear
        setGradientBackground(colorTop: UIColor.backgroundOrange!, colorBottom: UIColor.backgroundRed!)
        navigationController?.navigationBar.isHidden = true

    }

}

extension ProjectViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Project.projects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Project", for: indexPath)
        cell.textLabel?.text = Project.projects[indexPath.row].identifier
        let configuration = UIImage.SymbolConfiguration(paletteColors: [UIColor.backgroundRed!, UIColor.backgroundOrange!])
        cell.imageView?.image = UIImage(systemName: Project.projects[indexPath.row].image, withConfiguration: configuration)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let vc = storyboard?.instantiateViewController(withIdentifier: Project.projects[indexPath.row].identifier) {
            navigationController?.navigationBar.isHidden = false
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}


extension ProjectViewController {
    func setGradientBackground(colorTop: UIColor, colorBottom: UIColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorBottom.cgColor, colorTop.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.0)
        gradientLayer.locations = [0, 1]
        gradientLayer.frame = view.bounds

        view.layer.insertSublayer(gradientLayer, at: 0)
    }
}
