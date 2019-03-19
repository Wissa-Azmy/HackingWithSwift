//
//  ViewController.swift
//  Project7
//
//  Created by TwoStraws on 15/08/2016.
//  Copyright © 2016 Paul Hudson. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
	var petitions = [Petition]()
    var filteredPetitions = [Petition]()

	override func viewDidLoad() {
		super.viewDidLoad()

		let urlString: String
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(filterItems))
        tableView.tableFooterView = UIView()

		if navigationController?.tabBarItem.tag == 0 {
			urlString = "https://api.whitehouse.gov/v1/petitions.json?limit=100"
		} else {
			urlString = "https://api.whitehouse.gov/v1/petitions.json?signatureCountFloor=10000&limit=100"
		}

        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                parse(json: data)
                return
            }
        }

        showError()
	}

    func parse(json: Data) {
        let decoder = JSONDecoder()

        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
            petitions = jsonPetitions.results
            filteredPetitions = petitions
            tableView.reloadData()
        }
    }

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return filteredPetitions.count
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

		let petition = filteredPetitions[indexPath.row]
        cell.textLabel?.text = petition.title
        cell.detailTextLabel?.text = petition.body

		return cell
	}

	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let vc = DetailViewController()
		vc.detailItem = filteredPetitions[indexPath.row]
		navigationController?.pushViewController(vc, animated: true)
	}

	func showError() {
		let ac = UIAlertController(title: "Loading error", message: "There was a problem loading the feed; please check your connection and try again.", preferredStyle: .alert)
		ac.addAction(UIAlertAction(title: "OK", style: .default))
		present(ac, animated: true)
	}
    
    @objc private func filterItems(){
        let ac = UIAlertController(title: "Search Items", message: nil, preferredStyle: .alert)
        ac.addTextField()
        let action = UIAlertAction(title: "Search", style: .default) { [unowned self] action in
            let filterString = ac.textFields?[0].text ?? ""
            let filterResult = self.petitions.filter({
                $0.title.contains(filterString)
            })
            self.filteredPetitions = filterResult
            self.tableView.reloadData()
        }
        
        ac.addAction(action)
        present(ac, animated: true)
    }
}

