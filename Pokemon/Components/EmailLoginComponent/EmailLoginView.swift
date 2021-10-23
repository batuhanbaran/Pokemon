//
//  EmailLoginView.swift
//  WeatherApplication
//
//  Created by Erkut Bas on 19.10.2021.
//

import UIKit

class EmailLoginView: GenericBaseView<EmailLoginViewData> {
    
    private lazy var containerView: UIView = {
        let temp = UIView()
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.backgroundColor = .lightGray
        temp.layer.borderColor = UIColor.lightGray.cgColor
        temp.layer.borderWidth = 1.0
        temp.layer.cornerRadius = 8.0
        temp.clipsToBounds = true
        return temp
    }()
    
    private lazy var mainStackView: UIStackView = {
        let temp = UIStackView(arrangedSubviews: [userName, password])
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.alignment = .fill
        temp.distribution = .fill
        temp.axis = .vertical
        temp.spacing = 1
        return temp
    }()
    
    private lazy var userName: TextFieldView = {
        let temp = TextFieldView()
        temp.translatesAutoresizingMaskIntoConstraints = false
        return temp
    }()
    
    private lazy var password: TextFieldView = {
        let temp = TextFieldView()
        temp.translatesAutoresizingMaskIntoConstraints = false
        return temp
    }()
    
    override func addMajorViewComponents() {
        super.addMajorViewComponents()
        addContainers()
    }
    
    private func addContainers() {
        addSubview(containerView)
        containerView.addSubview(mainStackView)
        
        NSLayoutConstraint.activate([
        
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),

            mainStackView.topAnchor.constraint(equalTo: containerView.topAnchor),
            
            mainStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            
            mainStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            
            mainStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            
        ])
    }

    override func loadDataView() {
        super.loadDataView()
        guard let data = returnData() else { return }
        userName.setData(by: data.email)
        password.setData(by: data.password)
    }
}
