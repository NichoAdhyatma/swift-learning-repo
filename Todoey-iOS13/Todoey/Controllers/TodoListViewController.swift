//
//  ViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    var todos: [TodoModel] = [TodoModel]()
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
    }
    
    //MARK: - Tableview  Datasource Methods
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
    
    //MARK: - Tableview Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        todos[indexPath.row].done = todos[indexPath.row].done == true ? false : true
        
        saveData()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK: - Add New Item
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField: UITextField?
        
        let alert = UIAlertController(title: "Add New Todo", message: nil, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Todo", style: .default) { [self] (_) in
            let todo = TodoModel(title: textField?.text ?? "", done: false)
            
            todos.append(todo)
            
            saveData()
            
        }
        
        alert.addTextField() {
            alertTextField in
            
            alertTextField.placeholder = "Enter your todo"
            
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true)
    }
    
    //MARK: - Data Manipulation Methods
    
    func saveData() {
        do {
            let encoder = PropertyListEncoder()
            
            let encodedData = try encoder.encode(todos)
            
            if let filePath = dataFilePath {
                try encodedData.write(to: filePath)
            }
            
            tableView.reloadData()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func loadData() {
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            
            do {
                todos = try decoder.decode([TodoModel].self, from: data)
            } catch {
                print("Error decoding data: \(error)")
            }
        }
    }
    
}


