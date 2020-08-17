//
//  JobsListViewController.swift
//  Freela
//
//  Created by Albert Rayneer on 11/08/20.
//  Copyright © 2020 Albert Rayneer. All rights reserved.
//

import UIKit

class JobsListViewController: UIViewController {

    var jobs = [Job]()
    
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
        
        JobRepository().readAll { (job) in
            print(job)
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
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "jobCell") as? JobTableViewCell
        if let cell = cell {
            cell.config(title: "Very good job", payment: "100", time: "10 hours", requirements: "23")
        }
        
        return cell ?? UITableViewCell()
    }
    
}
