//
//  PlaceDetails.swift
//  GetGoingClass
//
//  Created by Alla Bondarenko on 2019-01-23.
//  Copyright © 2019 SMU. All rights reserved.
//

import Foundation
import CoreLocation

class PlaceDetails: NSObject, NSCoding {
    struct PropertyKey {
        static let idKey = "id"
        static let nameKey = "name"
        static let latitudeKey = "latitude"
        static let longitudeKey = "longitude"
        static let vicinityKey = "vicinity"
        static let formattedAddressKey = "formattedAddress"
        static let ratingKey = "rating"
        static let iconKey = "icon"
        static let placeIDKey = "place_id"
        static let websiteKey = "website"
        static let phoneNumberKey = "phoneNumber"
    }

    // MARK : - Properties

    var id: String
    var placeID: String
    var name: String?
    var coordinate: CLLocationCoordinate2D?
    var vicinity: String?
    var formattedAddress: String?
    var rating: Double?
    var icon: String?
    var phoneNumber: String?
    var websiteURL: String?
    var address: String? {
        return formattedAddress ?? vicinity
    }

    //MARK: - NSCoding
    func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: PropertyKey.idKey)
        aCoder.encode(placeID, forKey: PropertyKey.placeIDKey)
        aCoder.encode(name, forKey: PropertyKey.nameKey)
        aCoder.encode(vicinity, forKey: PropertyKey.vicinityKey)
        aCoder.encode(formattedAddress, forKey: PropertyKey.formattedAddressKey)
        if let rating = rating {
            aCoder.encode(rating, forKey: PropertyKey.ratingKey)
        }
        if let coordinate = coordinate {
            aCoder.encode(coordinate.latitude, forKey: PropertyKey.latitudeKey)
            aCoder.encode(coordinate.longitude, forKey: PropertyKey.longitudeKey)
        }
        aCoder.encode(icon, forKey: PropertyKey.iconKey)
    }

    required convenience init?(coder aDecoder: NSCoder) {
        let id = aDecoder.decodeObject(forKey: PropertyKey.idKey) as? String ?? ""
        let placeID = aDecoder.decodeObject(forKey: PropertyKey.placeIDKey) as? String ?? ""
        let name = aDecoder.decodeObject(forKey: PropertyKey.nameKey) as? String
        let vicinity = aDecoder.decodeObject(forKey: PropertyKey.vicinityKey) as? String
        let formattedAddress = aDecoder.decodeObject(forKey: PropertyKey.formattedAddressKey) as? String
        let rating = aDecoder.decodeDouble(forKey: PropertyKey.ratingKey)
        let icon = aDecoder.decodeObject(forKey: PropertyKey.iconKey) as? String
        let latitude = aDecoder.decodeDouble(forKey: PropertyKey.latitudeKey)
        let longitude = aDecoder.decodeDouble(forKey: PropertyKey.longitudeKey)
        let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)

        self.init(id: id, placeID: placeID, coordinate: coordinate, name: name, vicinity: vicinity, formattedAddress: formattedAddress, rating: rating, icon: icon)
    }

    // MARK: - Initializers

    init(id: String, placeID: String, coordinate: CLLocationCoordinate2D?, name: String?, vicinity: String?, formattedAddress: String?, rating: Double?, icon: String?) {
        self.id = id
        self.placeID = placeID
        self.name = name
        self.vicinity = vicinity
        self.formattedAddress = formattedAddress
        self.rating = rating
        self.icon = icon
        self.coordinate = coordinate
    }

    init?(json: [String: Any]) {
        guard let id = json["id"] as? String,
            let placeID = json["place_id"] as? String else { return nil }
        self.id = id
        self.placeID = placeID

        self.name = json["name"] as? String
        self.vicinity = json["vicinity"] as? String
        self.formattedAddress = json["formatted_address"] as? String

        if let geometry = json["geometry"] as? [String: Any] {
            if let location = geometry["location"] as? [String: Any] {
                if let latitude = location["lat"] as? Double,
                    let longitude = location["lng"] as? Double {
                    self.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                }
            }
        }
        self.rating = json["rating"] as? Double

        self.icon = json["icon"] as? String

    }

    // MARK: - Configuration

    func updatePlaceDetails(json: [String: Any]) {
        self.phoneNumber = json["formatted_phone_number"] as? String
        self.websiteURL = json["website"] as? String
    }

}
