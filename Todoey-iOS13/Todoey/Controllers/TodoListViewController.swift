//
//  ViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import CoreData

class TodoListViewController: UITableViewController {
    var coreDataManager = CoreDataManager<TodoEntity>()
    
    var category: CategoryEntity? {
        didSet {
            if let name = category?.name {
                coreDataManager.globalPredicates = [NSPredicate(format: "parentCategory.name MATCHES %@", name)]
                
                coreDataManager.loadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        coreDataManager.delegate = self
    }
    
    //MARK: - Tableview Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coreDataManager.items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constant.todoCellIdentified, for: indexPath)
        
        let todo =  coreDataManager.items[indexPath.row]
        
        cell.textLabel?.text = todo.title
        
        cell.accessoryType = todo.done == true ? .checkmark : .none
        
        return cell
    }
    
    //MARK: - Tableview Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let todo = coreDataManager.items[indexPath.row]
        
        todo.done = todo.done == true ? false : true
        
        coreDataManager.saveAndLoadContext()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Delete") { [self] (action, view, completion) in
            showDeleteTodoDialog(todo: coreDataManager.items[indexPath.row])
            
            completion(true)
        }
        
        let update = UIContextualAction(style: .normal, title: "Edit" ) {[self] (action, view, completion) in
            showUpateTodoDialog(todo: coreDataManager.items[indexPath.row])
            
            completion(true)
        }
        
        update.backgroundColor = .systemYellow
        
        return UISwipeActionsConfiguration(actions: [delete, update])
    }
    
    
    //MARK: - Handle Create Todo
    
    @IBAction func createTodoButtonPressed(_ sender: UIBarButtonItem) {
        showCreateTodoDialog()
    }
    
    //MARK: - Core Data CRUD
    
    func showCreateTodoDialog() {
        showDialogWithTextField(title: "Create Todo", message: "Create new entries in todo list", actionLabel: "Add", placeholder: "Todo title", onSubmit: {
            [self] submitText in
            
            let newTodo = coreDataManager.createEntity()
            
            newTodo.title = submitText
            
            newTodo.done = false
            
            newTodo.parentCategory = category
            
            coreDataManager.saveAndLoadContext()
        })
    }
    
    func showUpateTodoDialog(todo: TodoEntity) {
        showDialogWithTextField(title: "Update Todo \(todo.title ?? "")", message: "Update current selected todo", actionLabel: "Update", placeholder: "Update Todo Name") {
            [self] submitText in
            
            todo.title = submitText
            
            coreDataManager.saveAndLoadContext()
        }
    }
    
    func showDeleteTodoDialog(todo: TodoEntity) {
        showConfirmationDialog(title: "Delete Todo \(todo.title ?? "")", message: "Are you sure you want to delete todo?", confirmTitle: "Delete") { [self] (confirm) in
            if confirm {
                coreDataManager.delete(todo)
            }
        }
    }
}

//MARK: - Search Bar Delegate Method

extension TodoListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if(searchText.count == 0) {
            coreDataManager.loadData()
            
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        } else {
            let searchPredicate = NSPredicate(format: "title CONTAINS[cd] %@", searchText)
            
            let sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
            
            coreDataManager.loadData(predicates: [searchPredicate], sortDescriptors: sortDescriptors)
        }
    }
}

//MARK: - CoreDataManagerDelegate

extension TodoListViewController: CoreDataManagerDelegate {
    func didUpdateData() {
        tableView.reloadData()
    }
}
