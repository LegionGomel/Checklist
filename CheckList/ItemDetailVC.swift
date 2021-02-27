//
//  AddItemTableViewController.swift
//  CheckList
//
//  Created by Yuri Ershov on 27.02.21.
//

import UIKit

protocol itemDetailVCDelegate: class {
    func itemDetailVCDidCancel(_ controller: ItemDetailVC)
    func addItemVC(_ controller: ItemDetailVC, didFinishAdding item: ChecklistItem)
    func editItemVC(_ controller: ItemDetailVC, didFinishEditing item: ChecklistItem)
}

class ItemDetailVC: UITableViewController {
    
    weak var delegate: itemDetailVCDelegate?
    weak var toDoList: TodoList?
    weak var itemToEdit: ChecklistItem?
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var addButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        textField.delegate = self
        if let item = itemToEdit {
            title = "Edit item"
            textField.text = item.text
            addButton.isEnabled = true
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // Automatically show keyboard and cursor on text field
        textField.becomeFirstResponder()
    }

    @IBAction func cancel(_ sender: UIBarButtonItem) {
        delegate?.itemDetailVCDidCancel(self)
    }
    
    @IBAction func done(_ sender: Any) {
        if let item = itemToEdit,
           let text = textField.text {
            item.text = text
            delegate?.editItemVC(self, didFinishEditing: item)
        } else {
            if let item = toDoList?.newToDo() {
                if let textFieldText = textField.text {
                    item.text = textFieldText
                }
                item.checked = false
                delegate?.addItemVC(self, didFinishAdding: item)
            }
        }
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    // define is user can interact with cell
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }
}

extension ItemDetailVC: UITextFieldDelegate {
    
    // function for dismiss keyboard, also textField
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
    
    // method to manipulate what the user is typing
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let oldText = textField.text,
              let stringRange = Range(range, in: oldText) else {
            return false
        }
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        if newText.isEmpty {
            addButton.isEnabled = false
        } else {
            addButton.isEnabled = true
        }
        return true
    }
    
}
