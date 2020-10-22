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
import CloudKit

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
    
    // MARK: Using Cloud Kit
    let privateDataBase = CKContainer(identifier: "iCloud.Freela").privateCloudDatabase
    
    func createNewJob(job: Job) {
        let record = CKRecord(recordType: "Job")
        record.setValue(job.title, forKey: "title")
        record.setValue(job.type, forKey: "type")
        record.setValue(job.description, forKey: "desc")
        record.setValue(job.location, forKey: "location")
//        record.setValue(job.url, forKey: "url")
        record.setValue(job.company, forKey: "company")
        
        privateDataBase.save(record) { (savedRecord, error) in
            if error != nil {
                print("Failed to read data from Cloud Kit \(String(describing: error?.localizedDescription))")
            } else {
                print("\(String(describing: savedRecord)) record saved successfully!")
            }
        }
    }
    
    func readAllJobs(completion: @escaping ([CKRecord]) -> Void) {
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: "Job", predicate: predicate)
        query.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        let operation = CKQueryOperation(query: query)
        var jobsList = [CKRecord]()
        operation.recordFetchedBlock = { record in
            DispatchQueue.main.async {
                jobsList.append(record)
            }
        }
        operation.queryCompletionBlock = { cursor, error in
            if error == nil {
                completion(jobsList)
            }
        }
        
        privateDataBase.add(operation)
    }
    
    func deleteJob(job: CKRecord, completion: @escaping (Bool) -> Void) {
        privateDataBase.delete(withRecordID: job.recordID) { (recordID, error) in
            if error != nil {
                print("Failed to delete record \(String(describing: error?.localizedDescription))")
                completion(false)
            } else {
                print("Record of id \(String(describing: recordID)) deleted!")
                completion(true)
            }
        }
        
    }
}
