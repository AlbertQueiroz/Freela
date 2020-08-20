//
//  Job.swift
//  Freela
//
//  Created by Albert Rayneer on 11/08/20.
//  Copyright © 2020 Albert Rayneer. All rights reserved.
//

import Foundation

struct Job: Codable {
    let id: UUID
    let title: String?
    let description: String?
    let url: URL?
    let company: String?
    let location: String?
    let type: String?
    
    init() {
        self.id = UUID()
        self.title = "Job"
        self.description = "description"
        self.url = URL(string: "")
        self.company = "company"
        self.location = "location"
        self.type = "Full-time"
    }
}
