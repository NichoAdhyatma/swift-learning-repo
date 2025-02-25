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
    
    var todos: [TodoEntity] = [TodoEntity]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
    }
    
    //MARK: - Tableview Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constant.todoCellIdentified, for: indexPath)
        
        let todo =  todos[indexPath.row]
        
        cell.textLabel?.text = todo.title
        
        cell.accessoryType = todos[indexPath.row].done == true ? .checkmark : .none
        
        return cell
    }
    
    //MARK: - Tableview Delegate Methods : Did Select Row
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        todos[indexPath.row].done = todos[indexPath.row].done == true ? false : true
        
        saveData()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    //MARK: - Handle Swipe Delete and Update Todo
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Delete") { [self] (action, view, completion) in
            showDeleteTodoDialog(id: indexPath.row)
            
            completion(true)
        }
        
        let update = UIContextualAction(style: .normal, title: "Edit" ) {[self] (action, view, completion) in
            showUpateTodoDialog(id: indexPath.row)
            
            completion(true)
        }
        
        update.backgroundColor = .systemYellow
        
        return UISwipeActionsConfiguration(actions: [delete, update])
    }
    
    
    //MARK: - Handle Create Todo
    
    @IBAction func createTodoButtonPressed(_ sender: UIBarButtonItem) {
        showCreateTodoDialog()
    }
    
    //MARK: - Dialog Add, Update, & Delete Todo
    
    func showCreateTodoDialog() {
        showDialogWithTextField(title: "Create Todo", message: "Create new entries in todo list", actionLabel: "Add", placeholder: "Todo title", onSubmit: {
            [self] submitText in
            
            let newTodo = TodoEntity(context: context)
            
            newTodo.title = submitText
            
            newTodo.done = false
            
            self.saveData()
        })
    }
    
    func showUpateTodoDialog(id index: Int) {
        showDialogWithTextField(title: "Update Todo \(todos[index].title ?? "")", message: "Update current selected todo", actionLabel: "Update", placeholder: "Update Todo Name") {
            [self] submitText in
            
            todos[index].title = submitText
            
            saveData()
        }
    }
    
    func showDeleteTodoDialog(id index: Int) {
        showConfirmationDialog(title: "Delete Todo \(todos[index].title ?? "")", message: "Are you sure you want to delete todo?", confirmTitle: "Delete") { [self] (confirm) in
            if confirm {
                context.delete(todos[index])
                
                saveData()
            }
        }
    }
    
    //MARK: - Data Manipulation Methods
    
    func saveData() {
        do {
            try context.save()
            
            loadData()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func loadData(_ request: NSFetchRequest<TodoEntity> = TodoEntity.fetchRequest()) {
        do {
            todos = try context.fetch(request)
            
            tableView.reloadData()
        } catch {
            print(error.localizedDescription)
        }
    }
}

//MARK: - Search Bar Delegate Method

extension TodoListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if(searchText.count == 0) {
            loadData()
            
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        } else {
            let request: NSFetchRequest<TodoEntity> = TodoEntity.fetchRequest()
            
            request.predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchText)
            
            request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
            
            loadData(request)
        }
    }
}
