//
//  LottieView.swift
//  HW4_BatuhanBaran
//
//  Created by Batuhan BARAN on 13.10.2021.
//

import Foundation
import UIKit
import Lottie

protocol LottieViewOutputDelegate: AnyObject {
    func navigateToMainView()
}

class LottieView: BaseView {
    
    private lazy var containerView: UIView = {
        let temp = UIView()
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.clipsToBounds = true
        return temp
    }()

    private var animation = Animation.named("")
    private var animationView = AnimationView(animation: Animation.named(""))
    
    weak var delegate: LottieViewOutputDelegate?
    
    override func addMajorViewComponents() {
        setupViewConfigurations()
    }
    
    private var jsonName = ""
    
    convenience init(frame: CGRect, jsonName: String) {
        self.init(frame: frame)
        self.jsonName = jsonName
    }
    
    override func setupViewConfigurations() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.delegate?.navigateToMainView()
        }
    }
    
    func buildLottieView() -> Self {
        let jsonName = jsonName
        animation = Animation.named(jsonName)
        animationView = AnimationView(animation: animation)
        animationView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(containerView)
        containerView.addSubview(animationView)
        
        NSLayoutConstraint.activate([
        
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            animationView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            animationView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            animationView.topAnchor.constraint(equalTo: containerView.topAnchor),
            animationView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
            
        ])
        
        return self
    }
    
    func play() {
        animationView.play()
    }
    
    func stop() {
        animationView.stop()
    }
}
