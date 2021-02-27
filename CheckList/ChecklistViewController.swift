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
    
    func configureText(for cell: UITableViewCell, with item: ChecklistItem) {
        if let label = cell.viewWithTag(1000) as? UILabel {
            label.text = item.text
            }
    }
    
    // Checkmark configuration function
    func configureCheckmark (for cell: UITableViewCell, with item: ChecklistItem) {
        if item.checked {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        item.toggleChecked()
    }
}

