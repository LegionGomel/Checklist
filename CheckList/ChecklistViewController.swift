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
    
    // function to count items for tableView
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        toDoList.todos.count
    }
    
    // function to actually return cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChecklistItem", for: indexPath)
        if let label = cell.viewWithTag(1000) as? UILabel {
            label.text = toDoList.todos[indexPath.row].text
            }
        configureCheckmark(for: cell, at: indexPath)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Unselect checkmark when tap on cell
        if let cell = tableView.cellForRow(at: indexPath) {
            configureCheckmark(for: cell, at: indexPath)
            // Deselect row after tap on it
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    // Checkmark configuration function
    func configureCheckmark (for cell: UITableViewCell, at indexPath: IndexPath) {
        let toDoItem = toDoList.todos[indexPath.row]
        if toDoItem.checked {
            cell.accessoryType = .none
        } else {
            cell.accessoryType = .checkmark
        }
        toDoItem.checked = !toDoItem.checked
    }
}

