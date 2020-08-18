//
//  JobAPI.swift
//  Freela
//
//  Created by Albert Rayneer on 13/08/20.
//  Copyright © 2020 Albert Rayneer. All rights reserved.
//

import Foundation

enum JobAPI: Router {
    case readAll

    var hostname: String? {
        return "https://jobs.github.com"
    }
    
    var url: URL? {
        switch self {
        case .readAll: return URL(string: "\(hostname ?? "https://jobs.github.com")/positions.json?search=")
        }
    }
    
}
