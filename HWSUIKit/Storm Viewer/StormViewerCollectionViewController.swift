//
//  StormViewerCollectionViewController.swift
//  HWSUIKit
//
//  Created by Johan Forsell on 2022-04-08.
//

import UIKit

class StormViewerCollectionViewController: UICollectionViewController {
    var pictures = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Storm Viewer"
        navigationItem.largeTitleDisplayMode = .never
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareApp))
        
//        performSelector(inBackground: #selector(loadImages), with: nil)
        loadImages()
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
    
    @objc
    func shareApp() {
        let recommendation = "Check out this awesome app called \"Storm Viewer\"!"
        
        let vc = UIActivityViewController(activityItems: [recommendation], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Image", for: indexPath) as? StormImageCell else {
            fatalError("Unable to dequeue StormImageCell.")
        }
        let storm = pictures[indexPath.item]
        cell.fileName.text = (storm as NSString).deletingPathExtension
        cell.imageView.image = UIImage(named: storm)
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.selectedImage = pictures[indexPath.item]
            vc.numberOfImages = pictures.count
            vc.numberOfCurrentImage = indexPath.item + 1
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
