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
        
        alert.dismiss(animated: true)
        
        present(alert, animated: true)
    }
    
    func showDialogWithTextField(title: String?,message: String?,actionLabel: String?, placeholder: String? = nil,  defaultValue: String? = nil, onSubmit: @escaping (String) -> Void) {
        var textField: UITextField?
        
        let alert = DismissibleAlertController(title: title, message: message, preferredStyle: .alert)
        
        
        alert.addTextField() { alertTextField in
            alertTextField.placeholder = placeholder
            
            alertTextField.text = defaultValue
            
            textField = alertTextField
        }
        
        let action = UIAlertAction(title: actionLabel, style: .default) { _ in
            if let safeText = textField?.text {
                if safeText.replacingOccurrences(of: " ", with: "").count > 0 {
                    onSubmit(safeText)
                } else {
                    let errorAlert = DismissibleAlertController(title: "Error", message: "Please enter a value.", preferredStyle: .alert)
                    
                    errorAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    
                    errorAlert.dismiss(animated: true)
                    
                    self.present(errorAlert, animated: true)
                }
            }
        }
        
        alert.addAction(action)
        
        alert.dismiss(animated: true)
        
        present(alert, animated: true)
    }
    
}
