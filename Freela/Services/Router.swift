//
//  Router.swift
//  Freela
//
//  Created by Albert Rayneer on 13/08/20.
//  Copyright © 2020 Albert Rayneer. All rights reserved.
//

import Foundation

protocol Router {
    var hostname: String? { get }
    var url: URL? { get }
}
