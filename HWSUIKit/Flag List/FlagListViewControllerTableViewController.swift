//
//  FlagListerViewControllerTableViewController.swift
//  HWSUIKit
//
//  Created by Johan Forsell on 2022-02-21.
//

import UIKit

class FlagListViewControllerTableViewController: UITableViewController {
    var countries = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        
        title = "Flag List"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Country", for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.image = UIImage(named: countries[indexPath.row])
        content.imageProperties.cornerRadius = 2
        content.imageProperties.maximumSize = CGSize(width: 60, height: 30)
        content.text = capitalizedCountry(countries[indexPath.row])
        cell.contentConfiguration = content
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Flag Details") as? FlagDetailViewController {
            vc.country = countries[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func capitalizedCountry(_ country: String) -> String {
        if country.count == 2 {
            return country.uppercased()
        } else {
            return country.capitalized
        }
    }
}
