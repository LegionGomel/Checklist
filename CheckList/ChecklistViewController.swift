//
//  ViewController.swift
//  CheckList
//
//  Created by Yuri Ershov on 25.02.21.
//

import UIKit

class ChecklistViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // function to count ruts for tableView
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1000
    }
    
    // function to actually return cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChecklistItem", for: indexPath)
        if let label = cell.viewWithTag(1000) as? UILabel {
            let num = indexPath.row % 5
            switch num {
            case 0:
                label.text = "Take a jog"
            case 1:
                label.text = "Watch a movie"
            case 2:
                label.text = "Code an app"
            case 3:
                label.text = "Walk a dog"
            case 4:
                label.text = "Study design patterns"
            default:
                label.text = ""
            }
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Unselect checkmark when tap on cell
        if let cell = tableView.cellForRow(at: indexPath) {
            if cell.accessoryType == .none {
                cell.accessoryType = .checkmark
            } else {
                cell.accessoryType = .none
            }
        }
        // Deselect row after tap on it
        tableView.deselectRow(at: indexPath, animated: true)
    }


}

