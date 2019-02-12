//
//  DetailsViewController.swift
//  GetGoingClass
//
//  Created by Alla Bondarenko on 2019-02-11.
//  Copyright © 2019 SMU. All rights reserved.
//

import UIKit
import MapKit

class DetailsViewController: UIViewController {
    // MARK: - IBOutlets

    @IBOutlet weak var phoneNumberTextView: UITextView!
    @IBOutlet weak var websiteTextView: UITextView!

    @IBOutlet weak var mapView: MKMapView!

    // MARK: - Properties

    var place: PlaceDetails!

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = place.name
        loadPlaceDetails()
        setMapViewCoordinate()
    }

    func setMapViewCoordinate() {
        mapView.delegate = self

        guard let coordinate = place.coordinate else { return }
        let annotation = MKPointAnnotation()
        annotation.title = place.name
        annotation.coordinate = coordinate
        mapView.addAnnotation(annotation)
        centerMapOnLocation(location: coordinate)

        // indicates in blue user's current location if available
        mapView.showsUserLocation = true
    }

    func centerMapOnLocation(location: CLLocationCoordinate2D) {
        let radius = 5000

        let distance = CLLocationDistance(Double(radius) * 2)
        let region = MKCoordinateRegion.init(center: location, latitudinalMeters: distance, longitudinalMeters: distance)

        mapView.setRegion(region, animated: true)
    }

    private func loadPlaceDetails() {
        GooglePlacesAPI.requestPlaceDetails(for: place.placeID) { (status, json) in
            guard let jsonObj = json else {
                DispatchQueue.main.async {
                    self.phoneNumberTextView.isHidden = true
                    self.websiteTextView.isHidden = true
                }
                return
            }
            APIParser.parsePlaceDetails(place: &self.place, jsonObj: jsonObj)
            DispatchQueue.main.async {
                if let phoneNumber = self.place.phoneNumber {

                    self.phoneNumberTextView.text = phoneNumber
                } else {
                    self.phoneNumberTextView.isHidden = true
                }

                if let websiteURL = self.place.websiteURL {
                    self.websiteTextView.text = websiteURL
                } else {
                    self.websiteTextView.isHidden = true
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

extension DetailsViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation.isKind(of: MKUserLocation.self) {
            return nil
        }

        let view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "reusablePin")
        // allowing to show extra information in the pin view
        view.canShowCallout = true
        // "i" button
        view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        view.pinTintColor = UIColor.blue

        return view
    }

    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        let location = view.annotation

        let launchingOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeTransit]
        if let coordinate = location?.coordinate {
            location?.mapItem(coordinate: coordinate).openInMaps(launchOptions: launchingOptions)
        }
    }
}


extension MKAnnotation {
    func mapItem(coordinate: CLLocationCoordinate2D) -> MKMapItem {
        let placemark = MKPlacemark(coordinate: coordinate)
        return MKMapItem(placemark: placemark)
    }
}
