//
//  ProfileViewController.swift
//  Freela
//
//  Created by Albert Rayneer on 11/08/20.
//  Copyright © 2020 Albert Rayneer. All rights reserved.
//

import UIKit

class ProfileViewController: UITableViewController {

    @IBOutlet weak var profileImage: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.profileImage.layer.cornerRadius = self.profileImage.frame.height/2
        self.title = "Profile"
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            self.navigationController?.pushViewController(FavoriteJobsViewController(), animated: true)
        default:
            return
        }
    }
}
