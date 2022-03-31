//
//  ProjectViewController.swift
//  HWSUIKit
//
//  Created by Johan Forsell on 2022-02-15.
//

import UIKit

class ProjectViewController: UIViewController {
    @IBOutlet var projectTableView: UITableView!
    
    let gradientLayer: CAGradientLayer = {
        let layer = CAGradientLayer()
        layer.colors = [UIColor.backgroundOrange!.cgColor, UIColor.backgroundRed!.cgColor]
        layer.startPoint = CGPoint(x: 1.0, y: 0.0)
        layer.endPoint = CGPoint(x: 0.0, y: 1.0)
        layer.locations = [0, 1]
        
        return layer
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
                
        projectTableView.delegate = self
        projectTableView.dataSource = self
        projectTableView.backgroundColor = .clear
        navigationItem.largeTitleDisplayMode = .never
        view.layer.insertSublayer(gradientLayer, at: 0)
        gradientLayer.frame = view.bounds

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        gradientLayer.frame = view.bounds
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let header = view as? UITableViewHeaderFooterView {
            header.textLabel?.textColor = .white
        }
    }

}

extension ProjectViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return Project.sections.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return Project.sections[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Project.projects[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Project", for: indexPath)
        cell.textLabel?.text = Project.projects[indexPath.section][indexPath.row].identifier
        let configuration = UIImage.SymbolConfiguration(paletteColors: [UIColor.backgroundRed!, UIColor.backgroundRed!.withAlphaComponent(0.5)])
        cell.imageView?.image = UIImage(systemName: Project.projects[indexPath.section][indexPath.row].image, withConfiguration: configuration)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let vc = storyboard?.instantiateViewController(withIdentifier: Project.projects[indexPath.section][indexPath.row].identifier) {
            navigationController?.navigationBar.isHidden = false
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
