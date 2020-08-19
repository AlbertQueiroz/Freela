//
//  FavoriteJobRepository.swift
//  Freela
//
//  Created by Albert Rayneer on 19/08/20.
//  Copyright © 2020 Albert Rayneer. All rights reserved.
//

import Foundation

class FavoriteJobRepository {
    
    var items: [Job] = []
    
    func createNewItem(item: Job) -> Job {
        items.append(item)
        //Persists with File manager
        
        return item
    }
    
    func readAllItems() -> [Job] {
        return items
    }
    
    func delete(id : UUID) {
        items.removeAll(where: { $0.id == id })
    }
}
