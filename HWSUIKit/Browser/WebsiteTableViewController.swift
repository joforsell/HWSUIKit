//
//  WebsiteTableViewController.swift
//  HWSUIKit
//
//  Created by Johan Forsell on 2022-02-22.
//

import UIKit

class WebsiteTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Website.safeWebsites.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Website", for: indexPath)
        let address = Website.safeWebsites[indexPath.row].url
        let title = (address as NSString).deletingPathExtension
        cell.textLabel?.text = title.capitalized
        let configuration = UIImage.SymbolConfiguration(paletteColors: [UIColor.backgroundRed!, UIColor.backgroundRed!.withAlphaComponent(0.5)])
        cell.imageView?.image = UIImage(systemName: Website.safeWebsites[indexPath.row].icon, withConfiguration: configuration)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Easy Browser Content") as? EasyBrowserViewController {
            vc.initialWebsite = Website.safeWebsites[indexPath.row].url
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
