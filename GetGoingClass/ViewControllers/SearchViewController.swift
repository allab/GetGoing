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
        guard let query = searchParameter else {
            print("query is nil")
            return
        }
        GooglePlacesAPI.requestPlaces(query) { (status, json) in
            print(json ?? "")
        }
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
