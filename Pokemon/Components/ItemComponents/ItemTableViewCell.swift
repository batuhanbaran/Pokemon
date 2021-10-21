//
//  ItemTableViewCell.swift
//  Week_3
//
//  Created by Erkut Bas on 2.10.2021.
//

import UIKit

class ItemTableViewCell: BaseTableViewCell {
    
    private lazy var containerView: UIView = {
        let temp = UIView()
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.clipsToBounds = true
        temp.backgroundColor = .white
        return temp
    }()
    
    private lazy var titleLabel: UILabel = {
        let temp = UILabel()
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.textColor = .black
        temp.text = " "
        temp.lineBreakMode = .byWordWrapping
        temp.numberOfLines = 0
        temp.contentMode = .center
        temp.textAlignment = .left
        temp.font = FontManager.bold(18).value
        return temp
    }()

    override func addMajorViews() {
        super.addMajorViews()
        addUserComponents()
    }
    
    private func addUserComponents() {
        contentView.addSubview(containerView)
        containerView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10),
            
            titleLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10),
            
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
            
        ])
        
    }
    
    func setData(by value: GenericDataProtocol) {
        guard let data = value as? ItemTableViewCellData else { return }
        self.titleLabel.text = data.pokemonName
    }
}
