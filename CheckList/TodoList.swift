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
    
    private let priorityHeaders: [Priority: String] = [
        .high: "High Priority Todos",
        .medium: "Medium Priority Todos",
        .low: "Low Priority Todos",
        .none: "No Priority Todos"
    ]
    
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
        let row5Item = ChecklistItem()
        let row6Item = ChecklistItem()
        let row7Item = ChecklistItem()
        let row8Item = ChecklistItem()
        let row9Item = ChecklistItem()
        
        row0Item.text = "Take a jog"
        row1Item.text = "Watch a movie"
        row2Item.text = "Code an app"
        row3Item.text = "Walk a dog"
        row4Item.text = "Study design patterns"
        row5Item.text = "Take a sleep"
        row6Item.text = "Run a run"
        row7Item.text = "Clean my PC"
        row8Item.text = "Make a breakfast"
        row9Item.text = "Watch a movie again"
        
        
        addToDo(row0Item, for: .medium)
        addToDo(row1Item, for: .low)
        addToDo(row2Item, for: .medium)
        addToDo(row3Item, for: .high)
        addToDo(row4Item, for: .none)
        addToDo(row5Item, for: .medium)
        addToDo(row6Item, for: .low)
        addToDo(row7Item, for: .medium)
        addToDo(row8Item, for: .high)
        addToDo(row9Item, for: .none)
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
    
    func addToDo(_ item: ChecklistItem, for priority: Priority, at index: Int = -1) {
        switch priority {
        case .high:
            if index < 0 {
            highPriorityTodos.append(item)
            } else {
                highPriorityTodos.insert(item, at: index)
            }
        case .medium:
            if index < 0 {
            mediumPriorityTodos.append(item)
            } else {
                mediumPriorityTodos.insert(item, at: index)
            }
        case .low:
            if index < 0 {
            lowPriorityTodos.append(item)
            } else {
                lowPriorityTodos.insert(item, at: index)
            }
        case .none:
            if index < 0 {
            nonePriorityTodos.append(item)
            } else {
                nonePriorityTodos.insert(item, at: index)
            }
        }
    }
    
    func newToDo() -> ChecklistItem {
        let item = ChecklistItem()
        item.text = randomTitle()
        item.checked = true
        mediumPriorityTodos.append(item)
        return item
    }
    
    func priorityHeader(for section: Int) -> String {
        if let priority = Priority(rawValue: section) {
            return priorityHeaders[priority]!
        }
        return ""
    }
    
    func move(item: ChecklistItem, from sourceList: Priority, at sourceIndex: Int, to destinationList: Priority, at destinationIndex: Int) {
        remove(item, from: sourceList, at: sourceIndex)
        addToDo(item, for: destinationList, at: destinationIndex)
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
    
    private func randomTitle() -> String {
       let titles = ["New todo Item", "Generic todo", "Fill me out", "I need something to do", "Much todo about nothing"]
        let randomNumber = Int.random(in: 0...titles.count - 1)
        return titles[randomNumber]
    }
}
