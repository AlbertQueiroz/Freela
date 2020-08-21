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
        if let data = try? JSONEncoder().encode(item) {
            FileHelper().createFile(with: data, name: item.id.uuidString)
        }
        
        return item
    }
    
    func readAllItems() -> [Job] {
        //Read using FileManager
        let fileNames: [String] = FileHelper().contentsForDirectory(atPath: "")
        self.items = fileNames.compactMap { (fileName) -> Job? in
            if let data = FileHelper().retrieveFile(at: fileName) {
                let item = try? JSONDecoder().decode(Job.self, from: data)
                return item
            }
            return nil
        }
        
        return items
    }
    
    @discardableResult
    func delete(id : UUID) -> Bool {
//        items.removeAll(where: { $0.id == id })
        //Remove using File Manager
        return FileHelper().removeFile(at: id.uuidString)
        
    }
}
