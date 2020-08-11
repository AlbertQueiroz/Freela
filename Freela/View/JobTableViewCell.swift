//
//  JobTableViewCell.swift
//  Freela
//
//  Created by Albert Rayneer on 11/08/20.
//  Copyright © 2020 Albert Rayneer. All rights reserved.
//

import UIKit

class JobTableViewCell: UITableViewCell {

    let title: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let paymentIcon: UIImageView = {
        let imageView = UIImageView()
        
        return imageView
    }()

    let payment: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let timeIcon: UIImageView = {
        let imageView = UIImageView()
        
        return imageView
    }()
    
    let time: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let requirementsIcon: UIImageView = {
        let imageView = UIImageView()
        
        return imageView
    }()
    
    let requirements: UILabel = {
        let label = UILabel()
        return label
    }()
    
    func config(title: String, payment: String, time: String, requirements: String) {
        self.title.text = title
        self.payment.text = payment
        self.time.text = time
        self.requirements.text = requirements
    }
}
