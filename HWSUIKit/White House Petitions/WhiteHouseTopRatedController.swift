//
//  WhiteHouseTopRatedController.swift
//  HWSUIKit
//
//  Created by Johan Forsell on 2022-03-31.
//

import UIKit

class WhiteHouseTopRatedController: UITableViewController, UISearchBarDelegate {
    var petitions = [Petition]()
    var filteredPetitions = [Petition]()

    @IBOutlet var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        
        performSelector(inBackground: #selector(fetchJSON), with: nil)
    }
    
    @objc
    func fetchJSON() {
        let urlString = "https://www.hackingwithswift.com/samples/petitions-2.json"
        
        
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                parse(json: data)
                return
            }
        }
    
        performSelector(onMainThread: #selector(showError), with: nil, waitUntilDone: false)
    }
    
    @objc
    func showError() {
        let ac = UIAlertController(title: "Loading error", message: "There was a problem loading the feed; please check your connection and try again.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    func parse(json: Data) {
        let decoder = JSONDecoder()
        
        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
            petitions = jsonPetitions.results
            filteredPetitions = jsonPetitions.results
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        } else {
            performSelector(onMainThread: #selector(showError), with: nil, waitUntilDone: false)
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredPetitions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        let petition = filteredPetitions[indexPath.row]
        content.text = petition.title
        content.secondaryText = petition.body
        content.textProperties.numberOfLines = 1
        content.secondaryTextProperties.numberOfLines = 2
        cell.contentConfiguration = content
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = PetitionDetailViewController()
        vc.detailItem = filteredPetitions[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredPetitions = []
        
        if searchText == "" {
            filteredPetitions = petitions
        } else {
            for petition in petitions {
                if petition.title.lowercased().contains(searchText.lowercased()) || petition.body.lowercased().contains(searchText.lowercased()) {
                    filteredPetitions.append(petition)
                }
            }
        }
        
        self.tableView.reloadData()
    }
}
