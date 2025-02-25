//
//  ConfirmationDialog.swift
//  Todoey
//
//  Created by nicho@mac on 18/02/25.
//  Copyright © 2025 App Brewery. All rights reserved.
//

import UIKit


extension UIViewController {
    func showConfirmationDialog(title: String, message: String, confirmTitle: String, completion: @escaping (Bool) -> Void) {
        let alert = DismissibleAlertController(title: title, message: message, preferredStyle: .alert)
        
        let confirmAction = UIAlertAction(title: confirmTitle, style: .destructive) { _ in
            completion(true)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in
            completion(false)
        }
        
        alert.addAction(confirmAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
    
    func showDialogWithTextField(title: String?,message: String?,actionLabel: String?, placeholder: String? = nil, onSubmit: @escaping (String) -> Void) {
        var textField: UITextField?
        
        let alert = DismissibleAlertController(title: title, message: message, preferredStyle: .alert)
        
        
        alert.addTextField() { alertTextField in
            alertTextField.placeholder = placeholder
            
            textField = alertTextField
        }
        
        let action = UIAlertAction(title: actionLabel, style: .default) { _ in
            if let safeText = textField?.text {
                onSubmit(safeText)
            }
        }
        
        alert.addAction(action)
        
        present(alert, animated: true)
    }
    
}
