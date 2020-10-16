//
//  FavoriteJobRepository.swift
//  Freela
//
//  Created by Albert Rayneer on 19/08/20.
//  Copyright © 2020 Albert Rayneer. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class FavoriteJobRepository {
    
    var items: [Job] = []
    
    // MARK: Using File Manager
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
    func delete(id: UUID) -> Bool {
//        items.removeAll(where: { $0.id == id })
        //Remove using File Manager
        return FileHelper().removeFile(at: id.uuidString)
        
    }
    
    // MARK: Using Core Data
    func save(job: Job) {
        guard let context = getContext() else { return }
        let entity = NSEntityDescription.entity(forEntityName: "JobEntity", in: context)!
        let jobToSave = NSManagedObject(entity: entity, insertInto: context)
        
        jobToSave.setValue(job.title, forKey: "title")
        jobToSave.setValue(job.id, forKey: "id")
        jobToSave.setValue(job.type, forKey: "type")
        jobToSave.setValue(job.description, forKey: "desc")
        jobToSave.setValue(job.location, forKey: "location")
        jobToSave.setValue(job.url, forKey: "url")
        jobToSave.setValue(job.company, forKey: "company")
        
        do {
            try context.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
    }
    
    func readAll() -> [NSManagedObject] {
        var favoriteJobs = [NSManagedObject]()
        guard let context = getContext() else { return [] }
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "JobEntity")
        
        do {
            favoriteJobs = try context.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not read. \(error), \(error.userInfo)")
        }
        
        return favoriteJobs
    }
    
    func remove(job: NSManagedObject) -> Bool {
        guard let context = getContext() else { return false }
        context.delete(job)
        do {
            try context.save()
            return true
        } catch let error as NSError {
            print("Could not read. \(error), \(error.userInfo)")
            return false
        }
    }
    
    func getContext() -> NSManagedObjectContext? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return nil }
        let managedContext = appDelegate.persistentContainer.viewContext
    
        return managedContext
    }
}
