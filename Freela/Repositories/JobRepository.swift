//
//  JobRepository.swift
//  Freela
//
//  Created by Albert Rayneer on 13/08/20.
//  Copyright © 2020 Albert Rayneer. All rights reserved.
//

import Foundation

class JobRepository {
    
    var components = URLComponents()
    
    func readAll(completion: @escaping ([Job]) -> Void) {
        
        HTTP.get.request(url: JobAPI.readAll.url) { data, response, errorMessage in
            
            if let errorMessage = errorMessage {
                print(errorMessage)
                completion([])
                return
            }
            
            guard let data = data, let response = response else {
                completion([])
                return
            }
            
            switch response.statusCode {
            case 200:
                let jobs: [Job] = (try? JSONDecoder().decode(Array<Job>.self, from: data)) ?? []
                completion(jobs)
                return
            default:
                completion([])
                return
            }
        }
        
    }
    
}
