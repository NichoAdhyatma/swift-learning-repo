//
//  CategoryViewController.swift
//  Todoey
//
//  Created by nicho@mac on 24/02/25.
//  Copyright © 2025 App Brewery. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {
    
    var categories = [Category]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func createCategoryButtonPressed(_ sender: UIBarButtonItem) {
        showDialogWithTextField(title: "Create Category", message: "Create new entries for categories", actionLabel: "Create") {
            text in
            
        }
    }
    
    //MARK: - TableView Datasource
    
    
    //MARK: - TableView Delegate
}
