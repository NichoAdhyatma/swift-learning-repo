//
//  DissmissalbelAlert.swift
//  Todoey
//
//  Created by nicho@mac on 18/02/25.
//  Copyright © 2025 App Brewery. All rights reserved.
//
import UIKit

class DismissibleAlertController: UIAlertController {
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let superview = self.view.superview?.subviews.first {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissOnTapOutside))
            superview.addGestureRecognizer(tapGesture)
        }
    }

    @objc private func dismissOnTapOutside() {
        self.dismiss(animated: true, completion: nil)
    }
}
