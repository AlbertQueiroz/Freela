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
//        label.font = .boldSystemFont(ofSize: 16)
        label.font = UIFont(name: "Avenir Medium", size: 16)
        return label
    }()
    
    let location: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir", size: 14)
        return label
    }()
    
    let type: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir", size: 14)
        label.textColor = .darkGray
        return label
    }()
    
    let company: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir", size: 14)
        label.textColor = .darkGray
        return label
    }()
    
    let favorite: UIButton = {
        let button = UIButton()
        return button
    }()
    
    let stackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.alignment = .leading
        stack.axis = .vertical
        stack.contentMode = .scaleAspectFit
        stack.spacing = 4
        stack.distribution = .equalSpacing
        return stack
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.accessoryType = .disclosureIndicator
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func config(title: String, company: String, type: String, location: String) {
        self.title.text = title
        self.company.text = company
        self.type.text = type
        self.location.text = location
    }
    
    func setupViews() {
        stackView.addArrangedSubview(title)
        stackView.addArrangedSubview(type)
        stackView.addArrangedSubview(company)
        stackView.addArrangedSubview(location)
        
        self.contentView.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 16),
            stackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -16),
            stackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16)
        ])
    }
}
