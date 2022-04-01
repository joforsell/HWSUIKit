//
//  ProjectViewController.swift
//  HWSUIKit
//
//  Created by Johan Forsell on 2022-02-15.
//

import UIKit

class ProjectViewController: UIViewController {
    @IBOutlet var projectTableView: UITableView!
    
    // Creates the background gradient.
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
    
    // Makes sure the background gradient frame stays up to date with to the view bounds.
    // Used to avoid tiling of the gradient when device is rotated.
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        gradientLayer.frame = view.bounds
    }
    
    // Hides the navigation bar.
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
    
    // Changes the color of the section titles between sections.
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let header = view as? UITableViewHeaderFooterView {
            header.textLabel?.textColor = .white
        }
    }
    
    // Increases the size of the first section header to avoid clipping.
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return (tableView.sectionHeaderHeight * 1.2)
        } else {
            return tableView.sectionHeaderHeight
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
        cell.textLabel?.text = Project.projects[indexPath.section][indexPath.row].iPadIdentifier
        let configuration = UIImage.SymbolConfiguration(paletteColors: [UIColor.backgroundRed!, UIColor.backgroundRed!.withAlphaComponent(0.5)])
        cell.imageView?.image = UIImage(systemName: Project.projects[indexPath.section][indexPath.row].image, withConfiguration: configuration)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        // Using ternary operator (condition ? executedIfTrue : executedIfFalse) to conditionally choose controller identifier.
        if let vc = storyboard?.instantiateViewController(withIdentifier: isPad() ? Project.projects[indexPath.section][indexPath.row].iPadIdentifier : Project.projects[indexPath.section][indexPath.row].identifier) {
            navigationController?.navigationBar.isHidden = false
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    // Checking if device is iPad or iPhone. Only iPads have .regular size class for both vertical and horizontal.
    private func isPad() -> Bool {
        return traitCollection.horizontalSizeClass == .regular && traitCollection.verticalSizeClass == .regular
    }
}
