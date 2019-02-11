//
//  SearchResultsViewController.swift
//  GetGoingClass
//
//  Created by Alla Bondarenko on 2019-01-23.
//  Copyright © 2019 SMU. All rights reserved.
//

import UIKit

class SearchResultsViewController: UIViewController {

    // MARK: - Outlets

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var sortingSegmentedControl: UISegmentedControl!

    //MARK: - Properties

    var places: [PlaceDetails]!

    // MARK: - View Controller

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self

        let nib = UINib(nibName: "SearchResultTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "SearchResultTableViewCell")
        updateSorting()
    }
    
    @IBAction func sortingSegmentedControlValueChanged(_ sender: UISegmentedControl) {
        updateSorting()
    }

    private func updateSorting() {
        switch sortingSegmentedControl.selectedSegmentIndex {
        case 0:
            places.sort(by: { $0.name ?? "" < $1.name ?? "" })
        case 1:
            places.sort(by: { $0.rating ?? 0.0 > $1.rating ?? 0.0 })
        default:
            break;
        }
        tableView.reloadData()
    }
    /*
     // MARK: - Navigation

     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */

}
extension SearchResultsViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchResultTableViewCell") as? SearchResultTableViewCell else { return UITableViewCell() }
        let place = places[indexPath.row]
        cell.nameLabel.text = place.name
        cell.vicinityLabel.text = place.address
        if let placeRating = place.rating {
            cell.rating.rating = Int(placeRating.rounded(.down))
        }
        DispatchQueue.global(qos: .background).async {
            if let iconStr = place.icon,
                let iconURL = URL(string: iconStr),
                let imageData = try? Data(contentsOf: iconURL) {
                DispatchQueue.main.async {
                    cell.iconImageView.image = UIImage(data: imageData)
                }
            } else {
                DispatchQueue.main.async {
                    cell.iconImageView.image = UIImage(named: "StarEmpty")
                }
            }

        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("row was selected at \(indexPath.section) \(indexPath.row)")
        guard let detailsViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailsViewController") as? DetailsViewController else { return }
        detailsViewController.place = places[indexPath.row]
        navigationController?.pushViewController(detailsViewController, animated: true)
    }
}
