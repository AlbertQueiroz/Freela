//
//  HTTP.swift
//  Freela
//
//  Created by Albert Rayneer on 17/08/20.
//  Copyright © 2020 Albert Rayneer. All rights reserved.
//

import Foundation

enum HTTP {
    case get
    
    func request(url: URL?,
                 header: [String : String] = ["Content-Type":"application/json"],
                 body: [String : Any] = [:],
                 completion: @escaping (Data?, HTTPURLResponse?, String?) -> Void = { data, response, error in }) {
        
        guard let url = url else {
            completion(nil, nil, "Invalid URL!")
            return
        }
        
        switch self {
        case .get:
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                completion(data, response as? HTTPURLResponse, error?.localizedDescription)
            }.resume()
        }
        
    }
}
