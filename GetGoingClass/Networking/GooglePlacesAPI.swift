//
//  GooglePlacesAPI.swift
//  GetGoingClass
//
//  Created by Alla Bondarenko on 2019-01-21.
//  Copyright © 2019 SMU. All rights reserved.
//

import Foundation

class GooglePlacesAPI {

    class func requestPlaces(_ query: String, completion: @escaping(_ status: Int, _ json: [String: Any]?) -> Void) {
        var urlComponents = URLComponents()
        urlComponents.scheme = Constants.scheme
        urlComponents.host = Constants.host
        urlComponents.path = Constants.textPlaceSearch

        urlComponents.queryItems = [
            URLQueryItem(name: "query", value: query),
            URLQueryItem(name: "key", value: Constants.apiKey)
        ]
        if let url = urlComponents.url {
            NetworkingLayer.getRequest(with: url, timeoutInterval: 500) { (status, data) in

                if let responseData = data,
                    let jsonResponse = try? JSONSerialization.jsonObject(with: responseData, options: .allowFragments) as? [String: Any] {
                    completion(status, jsonResponse)
                } else {
                    completion(status, nil)
                }
            }
        }
    }
}
