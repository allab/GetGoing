//
//  SearchViewController.swift
//  GetGoingClass
//
//  Created by Alla Bondarenko on 2019-01-16.
//  Copyright © 2019 SMU. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    // MARK: - Outlets

    @IBOutlet weak var searchTextField: UITextField!

    // MARK: - Properties
    var searchParameter: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        searchTextField.delegate = self
    }

    @IBAction func searchButtonAction(_ sender: UIButton) {
        print("search button was tapped")
        guard let query = searchTextField.text else {
            print("query is nil")
            return
        }
        searchTextField.resignFirstResponder()

        GooglePlacesAPI.requestPlaces(query) { (status, json) in
            print(json ?? "")
            guard let jsonObj = json else { return }
            let results = APIParser.parseNearbySearchResults(jsonObj: jsonObj)

            if results.isEmpty {
                // TODO: - Present an alert
                // On the main thread!
                DispatchQueue.main.async {
                    self.presentErrorAlert(message: "No results")
                }
            } else {
                self.presentSearchResults(places: results)
            }
        }
    }

    func presentSearchResults(places: [PlaceDetails]) {
        guard let searchResultsViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SearchResultsViewController") as? SearchResultsViewController else { return }

        searchResultsViewController.places = places
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(searchResultsViewController, animated: true)
        }
    }

    func presentErrorAlert(title: String = "Error", message: String?) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        let okButtonAction = UIAlertAction(title: "Ok",
                                     style: .default,
                                     handler: nil)
        alert.addAction(okButtonAction)
        present(alert, animated: true)
    }
}

extension SearchViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == searchTextField {
            searchTextField.resignFirstResponder()
            print("textFieldShouldReturn")
            return true
        }
        return false
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == searchTextField {
            searchParameter = textField.text
            print(textField.text ?? "")
        }
    }
}
