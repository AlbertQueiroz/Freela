//
//  FavoriteJobsViewController.swift
//  Freela
//
//  Created by Albert Rayneer on 11/08/20.
//  Copyright © 2020 Albert Rayneer. All rights reserved.
//

import UIKit
import CoreData
import CloudKit

class FavoriteJobsViewController: JobsListViewController {
    
    var favoriteJobs = [CKRecord]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()                
            }
        }
    }
    
    let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        setupBackgroundView()
        super.viewDidLoad()
        self.title = "Favorite Jobs"
        self.navigationItem.rightBarButtonItem = nil
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //CoreData
//        favoriteJobs = favoriteJobRepository.readAll()
        //FileManager
        startLoading()
        favoriteJobRepository.readAllJobs { (jobs) in
            self.favoriteJobs = jobs
            DispatchQueue.main.async {
                self.stopLoading()
            }
        }
    }
    
    private func setupBackgroundView() {
        view.addSubview(backgroundView)
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundView.leftAnchor.constraint(equalTo: view.leftAnchor),
            backgroundView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
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
            
            //CoreData
//            if favoriteJobRepository.remove(job: jobToDelete) {
//                tableView.beginUpdates()
//                favoriteJobs.remove(at: indexPath.row)
//                tableView.deleteRows(at: [indexPath], with: .left)
//                tableView.endUpdates()
//            }
            
            //FileManager
//            if self.favoriteJobRepository.delete(id: self.jobs[indexPath.row].id) {
//                self.jobs = self.favoriteJobRepository.readAllItems()
//                tableView.deleteRows(at: [indexPath], with: .left)
//            }
            //            jobs.remove(at: indexPath.row)
            
            //CloudKit
            self.tableView.beginUpdates()
            self.favoriteJobs.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .left)
            self.tableView.endUpdates()
            favoriteJobRepository.deleteJob(job: jobToDelete) { (successfull) in
                if successfull {
                    print("Successful deleted \(jobToDelete.recordID)")
                }
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteJobs.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let job = favoriteJobs[indexPath.row]
        if let url = URL(string: job["url"] as? String ?? "") {
            let destiny = JobDetailsViewController()
            
            destiny.url = url
            self.navigationController?.pushViewController(destiny, animated: true)
        }
        tableView.cellForRow(at: indexPath)?.isSelected = false
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let favoriteJob = favoriteJobs[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "jobCell") as? JobTableViewCell else { return UITableViewCell() }
        
        //Core Data
//        if let title = favoriteJob.value(forKey: "title") as? String,
//           let company = favoriteJob.value(forKey: "company") as? String,
//           let type = favoriteJob.value(forKey: "type") as? String,
//           let location = favoriteJob.value(forKey: "location") as? String {
//            cell.config(title: title, company: company, type: type, location: location)
//        }
        
        //CloudKit
        if let title = favoriteJob["title"] as? String,
            let company = favoriteJob["company"] as? String,
            let type = favoriteJob["type"] as? String,
            let location = favoriteJob["location"] as? String {
            cell.config(title: title, company: company, type: type, location: location)
        }
        
        return cell
    }
}
