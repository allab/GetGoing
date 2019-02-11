//
//  DetailsViewController.swift
//  GetGoingClass
//
//  Created by Alla Bondarenko on 2019-02-11.
//  Copyright © 2019 SMU. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    // MARK: - IBOutlets

    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var websiteLabel: UILabel!

    // MARK: - Properties

    var place: PlaceDetails!

    override func viewDidLoad() {
        super.viewDidLoad()

        loadPlaceDetails()
    }

    private func loadPlaceDetails() {
        GooglePlacesAPI.requestPlaceDetails(for: place.placeID) { (status, json) in
            guard let jsonObj = json else {
                DispatchQueue.main.async {
                    self.phoneNumberLabel.isHidden = true
                    self.websiteLabel.isHidden = true
                }
                return
            }
            APIParser.parsePlaceDetails(place: &self.place, jsonObj: jsonObj)
            DispatchQueue.main.async {
                if let phoneNumber = self.place.phoneNumber {

                    self.phoneNumberLabel.attributedText = NSMutableAttributedString(string: phoneNumber, attributes: [NSAttributedString.Key.link : phoneNumber])

                } else {
                    self.phoneNumberLabel.isHidden = true
                }

                if let websiteURL = self.place.websiteURL {
                    self.websiteLabel.attributedText = NSMutableAttributedString(string: websiteURL, attributes: [NSAttributedString.Key.link : websiteURL])

                } else {
                    self.websiteLabel.isHidden = true
                }
            }
        }
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
