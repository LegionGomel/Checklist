//
//  TodoList.swift
//  CheckList
//
//  Created by Yuri Ershov on 27.02.21.
//

import Foundation

class TodoList {
    enum Priority: Int, CaseIterable {
        case high
        case medium
        case low
        case none
    }
    
    private var highPriorityTodos: [ChecklistItem] = []
    private var mediumPriorityTodos: [ChecklistItem] = []
    private var lowPriorityTodos: [ChecklistItem] = []
    private var nonePriorityTodos: [ChecklistItem] = []
    
    init() {
        
        let row0Item = ChecklistItem()
        let row1Item = ChecklistItem()
        let row2Item = ChecklistItem()
        let row3Item = ChecklistItem()
        let row4Item = ChecklistItem()
        
        row0Item.text = "Take a jog"
        row1Item.text = "Watch a movie"
        row2Item.text = "Code an app"
        row3Item.text = "Walk a dog"
        row4Item.text = "Study design patterns"
        
        addToDo(row0Item, for: .medium)
        addToDo(row1Item, for: .medium)
        addToDo(row2Item, for: .medium)
        addToDo(row3Item, for: .medium)
        addToDo(row4Item, for: .medium)
    }
    
    func toDoList(for priority: Priority) -> [ChecklistItem] {
        switch priority {
        case .high:
            return highPriorityTodos
        case .medium:
            return mediumPriorityTodos
        case .low:
            return lowPriorityTodos
        case .none:
            return nonePriorityTodos
        }
    }
    
    func addToDo(_ item: ChecklistItem, for priority: Priority) {
        switch priority {
        case .high:
            highPriorityTodos.append(item)
        case .medium:
            mediumPriorityTodos.append(item)
        case .low:
            lowPriorityTodos.append(item)
        case .none:
            nonePriorityTodos.append(item)
        }
    }
    
    func newToDo() -> ChecklistItem {
        let item = ChecklistItem()
        item.text = randomTitle()
        item.checked = true
        mediumPriorityTodos.append(item)
        return item
    }
    
    func move(item: ChecklistItem, to index: Int) {
//        guard let currentIndex = todos.firstIndex(of: item) else {
//            return
//        }
//        todos.remove(at: currentIndex)
//        todos.insert(item, at: index)
    }
    
    
    func remove(_ item: ChecklistItem, from priority: Priority, at index: Int) {
        switch priority {
        case .high:
            highPriorityTodos.remove(at: index)
        case .medium:
            mediumPriorityTodos.remove(at: index)
        case .low:
            lowPriorityTodos.remove(at: index)
        case .none:
            nonePriorityTodos.remove(at: index)
        }
    }
//    func remove(items: [ChecklistItem]) {
//        for item in items {
//            if let index = todos.firstIndex(of: item) {
//                todos.remove(at: index)
//            }
//        }
//    }
    
    private func randomTitle() -> String {
       let titles = ["New todo Item", "Generic todo", "Fill me out", "I need something to do", "Much todo about nothing"]
        let randomNumber = Int.random(in: 0...titles.count - 1)
        return titles[randomNumber]
    }
}
