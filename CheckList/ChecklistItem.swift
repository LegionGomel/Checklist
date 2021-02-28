//
//  ChecklistItem.swift
//  CheckList
//
//  Created by Yuri Ershov on 27.02.21.
//

import Foundation

class ChecklistItem: NSObject {
    @objc var text = ""
    var checked = false
    
    func toggleChecked() {
        checked = !checked
    }
}
