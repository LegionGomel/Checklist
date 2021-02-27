//
//  ViewController.swift
//  CheckList
//
//  Created by Yuri Ershov on 25.02.21.
//

import UIKit

class ChecklistViewController: UITableViewController {
    var toDoList: TodoList
    
    required init?(coder: NSCoder) {
        toDoList = TodoList()
        super .init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func addItem(_ sender: UIBarButtonItem) {
        let newRowIndex = toDoList.todos.count
        
        // Create new todo item and add a row for it to tableview
        _ = toDoList.newToDo()
        let indexPath = IndexPath(row: newRowIndex, section: 0)
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: .automatic)
        
    }
    
    // function to count items for tableView
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        toDoList.todos.count
    }
    
    // function to actually return cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChecklistItem", for: indexPath)
        let item = toDoList.todos[indexPath.row]
        configureText(for: cell, with: item)
        configureCheckmark(for: cell, with: item)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Unselect checkmark when tap on cell
        if let cell = tableView.cellForRow(at: indexPath) {
            let item = toDoList.todos[indexPath.row]
            configureCheckmark(for: cell, with: item)
            // Deselect row after tap on it
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    // remove item when user press delete after swipe
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        toDoList.todos.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    
    func configureText(for cell: UITableViewCell, with item: ChecklistItem) {
        if let checkmarkCell = cell as? ChecklistTableViewCell {
            checkmarkCell.todoTextLabel.text = item.text
            }
    }
    
    // Checkmark configuration function
    func configureCheckmark (for cell: UITableViewCell, with item: ChecklistItem) {
        guard let checkmarkCell = cell as? ChecklistTableViewCell else {
            return
        }
        if item.checked {
            checkmarkCell.checkmarkLabel.text = "√"
        } else {
            checkmarkCell.checkmarkLabel.text = ""
        }
        item.toggleChecked()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addItemSegue" {
            if let addItemViewController = segue.destination as? ItemDetailVC {
                addItemViewController.delegate = self
                addItemViewController.toDoList = toDoList
            }
        } else if segue.identifier == "editItemSegue" {
            if let addItemVIewController = segue.destination as? ItemDetailVC {
                if let cell = sender as? UITableViewCell,
                   let indexPath = tableView.indexPath(for: cell) {
                    let item = toDoList.todos[indexPath.row]
                    addItemVIewController.itemToEdit = item
                    addItemVIewController.delegate = self
                }
            }
        }
    }
}

extension ChecklistViewController: itemDetailVCDelegate {
    
    func itemDetailVCDidCancel(_ controller: ItemDetailVC) {
        navigationController?.popViewController(animated: true)
    }
    
    func addItemVC(_ controller: ItemDetailVC, didFinishAdding item: ChecklistItem) {
        navigationController?.popViewController(animated: true)
        let rowIndex = toDoList.todos.count - 1
        let indexPath = IndexPath(row: rowIndex, section: 0)
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: .automatic)
    }
    
    func editItemVC(_ controller: ItemDetailVC, didFinishEditing item: ChecklistItem) {
        if let index = toDoList.todos.firstIndex(of: item) {
            let indexPath = IndexPath(row: index, section: 0)
            if let cell = tableView.cellForRow(at: indexPath) {
            configureText(for: cell, with: item)
            }
        }
        navigationController?.popViewController(animated: true)
    }
    
}


