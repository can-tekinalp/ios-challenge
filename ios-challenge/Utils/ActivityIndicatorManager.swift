//
//  ActivityIndicatorManager.swift
//  ios-challenge
//
//  Created by Can Tekinalp on 22.01.2022.
//

import UIKit

class ActivityIndicatorManager {
    
    static let shared = ActivityIndicatorManager()
    
    private let indicator: UIActivityIndicatorView = {
        var activity = UIActivityIndicatorView()
        if #available(iOS 13, *) {
            activity = UIActivityIndicatorView(style: .large)
        }
        return activity
    }()
    
    private lazy var view: UIView = {
        let view = UIView(frame: .zero)
        view.addSubview(indicator)
        indicator.anchorCenterSuperview()
        return view
    }()
    
    private var isActive = false
    
    private init() { }
    
    func show() {
        DispatchQueue.main.async {
            if self.isActive == false {
                self.isActive = true
                let window = UIApplication.shared.windows.filter({ $0.isKeyWindow}).first
                window?.addSubview(self.view)
                self.view.fillSuperView()
                self.indicator.startAnimating()
            }
        }
    }
    
    func hide() {
        DispatchQueue.main.async {
            if self.isActive == true {
                self.isActive = false
                self.indicator.stopAnimating()
                self.view.removeFromSuperview()
            }
        }
    }
}
