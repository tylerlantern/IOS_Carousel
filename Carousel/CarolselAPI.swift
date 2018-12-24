//
//  CarolselAPI.swift
//  Carousel
//
//  Created by Nattapong Unaregul on 7/16/17.
//  Copyright © 2017 Nattapong Unaregul. All rights reserved.
//

import UIKit


class CarolselAPI : NSObject {
    var session : URLSession!
    override init() {
        super.init()
        let queueImage = OperationQueue()
        queueImage.maxConcurrentOperationCount = 10
        queueImage.qualityOfService = .userInteractive
        let config = URLSessionConfiguration.default
        session = URLSession(configuration: config, delegate: nil, delegateQueue: nil)
    }
    func loadImage(imagePath:String,completion: @escaping (_ Image: UIImage?,_ error: Error?) -> Void ) -> URLSessionDataTask? {
        guard  let loadURL = URL(string: imagePath) else {
            completion( nil, NSError(domain: "Invalid URL", code: 0, userInfo: nil))
            return nil
        }
        var request = URLRequest(url: loadURL)
        request.httpMethod = "GET"
        let task = session.dataTask(with: request) { (data, response, error) in
            if let data = data {
                DispatchQueue.main.async(execute: {
                    completion(UIImage(data: data), nil)
                })
            }
        }
        task.resume()
        return task
    }
}
