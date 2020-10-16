//
//  FavoriteJobsViewController.swift
//  Freela
//
//  Created by Albert Rayneer on 11/08/20.
//  Copyright © 2020 Albert Rayneer. All rights reserved.
//

import UIKit
import CoreData

class FavoriteJobsViewController: JobsListViewController {
    
    var favoriteJobs = [NSManagedObject]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Favorite Jobs"
        self.navigationItem.rightBarButtonItem = nil
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        favoriteJobs = favoriteJobRepository.readAll()
    }
    
}

// MARK: Table view delegate methods
extension FavoriteJobsViewController {
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        return UISwipeActionsConfiguration()
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let jobToDelete = favoriteJobs[indexPath.row]
            if favoriteJobRepository.remove(job: jobToDelete) {
                tableView.beginUpdates()
                favoriteJobs.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .left)
                tableView.endUpdates()
            }
            
//            if self.favoriteJobRepository.delete(id: self.jobs[indexPath.row].id) {
//                self.jobs = self.favoriteJobRepository.readAllItems()
//                tableView.deleteRows(at: [indexPath], with: .left)
//            }
            //            jobs.remove(at: indexPath.row)
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteJobs.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let favoriteJob = favoriteJobs[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "jobCell") as? JobTableViewCell else { return UITableViewCell() }
        
        if let title = favoriteJob.value(forKey: "title") as? String,
           let company = favoriteJob.value(forKey: "company") as? String,
           let type = favoriteJob.value(forKey: "type") as? String,
           let location = favoriteJob.value(forKey: "location") as? String {
            cell.config(title: title, company: company, type: type, location: location)
        }
        
        return cell
    }
}
