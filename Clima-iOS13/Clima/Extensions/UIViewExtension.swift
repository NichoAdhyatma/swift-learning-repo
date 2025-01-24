//
//  UIViewExtension.swift
//  Clima
//
//  Created by nicho@mac on 24/01/25.
//  Copyright © 2025 App Brewery. All rights reserved.
//

import UIKit

extension UIViewController {
    func showErrorAlert(message: String) {
        let alertController = UIAlertController(
            title: "Error",
            message: message,
            preferredStyle: .alert
        )
        
        alertController.addAction(UIAlertAction(
            title: "OK",
            style: .default,
            handler: nil
        ))
        
        present(alertController, animated: true)
    }
    
    private struct LoadingView {
        static var loadingViewKey: UInt8 = 0
    }
    
    private var loadingView: UIView? {
        get {
            return objc_getAssociatedObject(self, &LoadingView.loadingViewKey) as? UIView
        }
        set {
            objc_setAssociatedObject(self, &LoadingView.loadingViewKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    func showLoadingView(message: String? = nil) {
        guard loadingView == nil else { return }
        
        let overlay = UIView(frame: self.view.bounds)
        overlay.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .white
        activityIndicator.startAnimating()
        overlay.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: overlay.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: overlay.centerYAnchor)
        ])
        
        if let message = message {
            let label = UILabel()
            label.text = message
            label.textColor = .white
            label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
            label.textAlignment = .center
            label.numberOfLines = 0
            overlay.addSubview(label)
            label.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                label.topAnchor.constraint(equalTo: activityIndicator.bottomAnchor, constant: 16),
                label.leadingAnchor.constraint(equalTo: overlay.leadingAnchor, constant: 20),
                label.trailingAnchor.constraint(equalTo: overlay.trailingAnchor, constant: -20)
            ])
        }
        
        self.view.addSubview(overlay)
        loadingView = overlay
    }
    
    func hideLoadingView() {
        loadingView?.removeFromSuperview()
        
        loadingView = nil
    }
}
