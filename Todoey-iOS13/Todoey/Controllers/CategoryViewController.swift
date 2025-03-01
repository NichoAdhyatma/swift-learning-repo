//
//  CategoryViewController.swift
//  Todoey
//
//  Created by nicho@mac on 24/02/25.
//  Copyright © 2025 App Brewery. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController, CoreDataManagerDelegate {
    var coreDataManager = CoreDataManager<CategoryEntity>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        coreDataManager.loadData()
        
        coreDataManager.delegate = self
    }
    
    @IBAction func createCategoryButtonPressed(_ sender: UIBarButtonItem) {
        showCreateCardDialog()
    }
    
    //MARK: - TableView Datasource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coreDataManager.items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constant.categoryCellIdentifier, for: indexPath)
        
        let category = coreDataManager.items[indexPath.row]
        
        cell.textLabel?.text = category.name
        
        return cell
    }
    
    //MARK: - TableView Delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: Constant.goToItemsSegueIdentifier, sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationViewController = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationViewController.category = coreDataManager.items[indexPath.row]
        }
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Delete") { [self] (action, view, completion) in
            showDeleteCategoryDialog(category: coreDataManager.items[indexPath.row])
            
            completion(true)
        }
        
        let update = UIContextualAction(style: .normal, title: "Edit" ) {[self] (action, view, completion) in
            showUpateCategoryDialog(category: coreDataManager.items[indexPath.row])
            
            completion(true)
        }
        
        update.backgroundColor = .systemYellow
        
        return UISwipeActionsConfiguration(actions: [delete, update])
    }
    
    
    //MARK: - Core Data CRUD
    
    func showCreateCardDialog() {
        showDialogWithTextField(title: "Create Category", message: "Create new entries for categories", actionLabel: "Create") {
            [self] text in
            let newCategory = coreDataManager.createEntity()
            
            newCategory.name = text
            
            coreDataManager.saveAndLoadContext()
            
        }
    }
    
    func showUpateCategoryDialog(category: CategoryEntity) {
        showDialogWithTextField(title: "Update Category \(category.name ?? "")", message: "Update current selected category", actionLabel: "Update", placeholder: "Update Categori Name", defaultValue: category.name) {
            [self] submitText in
            
            category.name = submitText
            
            coreDataManager.saveAndLoadContext()
        }
    }
    
    func showDeleteCategoryDialog(category: CategoryEntity) {
        showConfirmationDialog(title: "Delete Cateogry \(category.name ?? "")", message: "Are you sure you want to delete this category?", confirmTitle: "Delete") { [self] (confirm) in
            if confirm {
                coreDataManager.delete(category)
            }
        }
    }
    
    func didUpdateData() {
        tableView.reloadData()
    }
}
