//
//  TaskStore.swift
//  DICoreDataRealmTask
//
//  Created by Anas Bashandy on 26/7/20.
//  Copyright © 2020 Anas Bashandy. All rights reserved.
//

import Foundation

struct TaskStore {
    var allTasks = [Task]()
    
    var taskCount: Int {
        return allTasks.count
    }
    
    mutating func createTask(_ name: String) {
        let newTask = Task(name: name)
        allTasks.append(newTask)
    }
    
    func getTaskAt(index: Int) -> Task {
        return allTasks[index]
    }
    
    mutating func removeTask(_ task: Task) {
        if let index = allTasks.firstIndex(of: task) {
            allTasks.remove(at: index)
        }
    }
        
}
