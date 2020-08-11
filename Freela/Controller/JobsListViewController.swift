//
//  JobsListViewController.swift
//  Freela
//
//  Created by Albert Rayneer on 11/08/20.
//  Copyright © 2020 Albert Rayneer. All rights reserved.
//

import UIKit

class JobsListViewController: UIViewController {

    //MARK: Outlets
    @IBOutlet weak var tableView: UITableView!
    
    lazy var profileButton: UIBarButtonItem = {
        let button = UIBarButtonItem()
        button.image = UIImage(named: "")
        button.title = "Profile"
        button.target = self
        button.action = #selector(goToProfile)
        
        return button
        
    }()

    //MARK: ViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Jobs"
        self.tableView.delegate = self
        self.tableView.dataSource = self
            
        self.navigationItem.rightBarButtonItem = profileButton
    }
    
    @objc func goToProfile() {
        let storyboard = UIStoryboard(name: "Profile", bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: "profile")
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

//MARK: TableView Delegate and DataSource
extension JobsListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        UITableViewCell()
    }
    
    
}
