//
//  APIParser.swift
//  GetGoingClass
//
//  Created by Alla Bondarenko on 2019-01-23.
//  Copyright © 2019 SMU. All rights reserved.
//

import Foundation

class APIParser {

    class func parseNearbySearchResults(jsonObj: [String: Any]) -> [PlaceDetails] {
        //array of results, initialized as empty
        var places: [PlaceDetails] = []
        // parsing general root object
        if let results = jsonObj["results"] as? [[String: Any]] {
            results.forEach { (result) in
                if let place = PlaceDetails(json: result) {
                    places.append(place)
                }
            }
        }
        return places
    }

    class func parsePlaceDetails(place: inout PlaceDetails, jsonObj: [String: Any]) {
        if let placeDetails = jsonObj["result"] as? [String: Any] {
            place.updatePlaceDetails(json: placeDetails)
        }
    }
}
