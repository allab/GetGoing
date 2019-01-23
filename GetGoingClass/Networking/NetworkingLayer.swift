//
//  NetworkingLayer.swift
//  GetGoingClass
//
//  Created by Alla Bondarenko on 2019-01-21.
//  Copyright © 2019 SMU. All rights reserved.
//

import Foundation

class NetworkingLayer {

    class func getRequest(with url: URL, timeoutInterval: TimeInterval = 240, completion: @escaping(_ status: Int, _ data: Data?) -> Void) {
        let session = URLSession.shared

        let request = NSMutableURLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: timeoutInterval)

        let dataTask = session.dataTask(with: request as URLRequest) { (data, response, error) in

            let httpResponse = response as? HTTPURLResponse
            let statusCode = httpResponse?.statusCode ?? 500

            completion(statusCode, data)

        }
        dataTask.resume()
    }
}
