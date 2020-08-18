//
//  JobsListViewController.swift
//  Freela
//
//  Created by Albert Rayneer on 11/08/20.
//  Copyright © 2020 Albert Rayneer. All rights reserved.
//

import UIKit

class JobsListViewController: UIViewController {

    var jobs = [Job]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: Model
    
    // MARK: Views
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
        
    }()
    
    lazy var profileButton: UIBarButtonItem = {
        let button = UIBarButtonItem()
        
        button.image = .actions
//        button.image = UIImage(named: "profileImage")
        button.target = self
        button.action = #selector(goToProfile)
        
        return button
        
    }()

    // MARK: ViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        JobRepository().readAll { (jobs) in
            self.jobs = jobs
        }
        
        self.title = "Jobs"
        setupTableView()
            
        self.navigationItem.rightBarButtonItem = profileButton
    }
    
    func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(JobTableViewCell.self, forCellReuseIdentifier: "jobCell")
        self.view.addSubview(tableView)
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
    }
    
    @objc func goToProfile() {
        let storyboard = UIStoryboard(name: "Profile", bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: "profile")
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

// MARK: TableView Delegate and DataSource
extension JobsListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        jobs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let job = jobs[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "jobCell") as? JobTableViewCell
        
        if let cell = cell, let title = job.title, let company = job.company, let type = job.type, let location = job.location {
            cell.config(title: title, company: company, type: type, location: location)
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let url = jobs[indexPath.row].url {
            let destiny = JobDetailsViewController()
            
            self.navigationController?.present(destiny, animated: true, completion: nil)

            destiny.loadURL(with: url)
        }
        tableView.cellForRow(at: indexPath)?.isSelected = false
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let favoriteAction = UIContextualAction(style: .normal, title: "Favorite") { action, swipeButtonView, completion in
            //Favorite the job
            print("favorited")
            completion(true)
        }
        
        favoriteAction.image = .add
        favoriteAction.image?.withTintColor(.white)
        favoriteAction.backgroundColor = .systemBlue
        
        return UISwipeActionsConfiguration(actions: [favoriteAction])
    }
}
