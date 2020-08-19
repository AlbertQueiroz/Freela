//
//  FavoriteJobsViewController.swift
//  Freela
//
//  Created by Albert Rayneer on 11/08/20.
//  Copyright © 2020 Albert Rayneer. All rights reserved.
//

import UIKit

class FavoriteJobsViewController: JobsListViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Favorite Jobs"
        self.navigationItem.rightBarButtonItem = nil
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        jobs = favoriteJobRepository.readAllItems()
    }
    
}

// MARK: Table view delegate methods
extension FavoriteJobsViewController {
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        return UISwipeActionsConfiguration()
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            jobs.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .left)
            self.favoriteJobRepository.delete(id: self.jobs[indexPath.row].id)
            self.jobs = self.favoriteJobRepository.readAllItems()
        }
    }
    
}
