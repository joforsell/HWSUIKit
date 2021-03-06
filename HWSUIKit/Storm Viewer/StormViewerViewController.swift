//
//  StormViewerViewController.swift
//  HWSUIKit
//
//  Created by Johan Forsell on 2022-02-14.
//

import UIKit

class StormViewerViewController: UITableViewController {
    var pictures = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Storm Viewer"
        navigationItem.largeTitleDisplayMode = .never
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareApp))
        
        performSelector(inBackground: #selector(loadImages), with: nil)
    }

    @objc
    func loadImages() {
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        var items = try! fm.contentsOfDirectory(atPath: path)
        items.sort()
        
        for item in items {
            if item.hasPrefix("nssl") {
                pictures.append(item)
            }
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        var content = cell.defaultContentConfiguration()
        let filename = (pictures[indexPath.row] as NSString).deletingPathExtension
        let defaults = UserDefaults.standard
        let currentTaps = defaults.integer(forKey: pictures[indexPath.row])
        content.text = "\(currentTaps) - \(filename)"
        let configuration = UIImage.SymbolConfiguration(paletteColors: [UIColor.backgroundRed!, UIColor.backgroundRed!.withAlphaComponent(0.5)])
        content.image = UIImage(systemName: "photo.fill", withConfiguration: configuration)
        cell.contentConfiguration = content
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.selectedImage = pictures[indexPath.row]
            vc.numberOfImages = pictures.count
            vc.numberOfCurrentImage = indexPath.row + 1
            let defaults = UserDefaults.standard
            let currentTaps = defaults.integer(forKey: pictures[indexPath.row])
            defaults.set(currentTaps+1, forKey: pictures[indexPath.row])
            tableView.reloadData()
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc
    func shareApp() {
        let recommendation = "Check out this awesome app called \"Storm Viewer\"!"
        
        let vc = UIActivityViewController(activityItems: [recommendation], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
}

