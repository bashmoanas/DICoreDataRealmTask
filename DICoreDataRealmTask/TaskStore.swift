//
//  TaskStore.swift
//  DICoreDataRealmTask
//
//  Created by Anas Bashandy on 26/7/20.
//  Copyright © 2020 Anas Bashandy. All rights reserved.
//

import Foundation

struct TaskStore {
    
    var taskDataRepository = CDTaskRepository()
    
    var allTasks = [Task]()
    
    var taskCount: Int {
        return allTasks.count
    }
    
    func createTask(_ task: Task) {
//        let newTask = Task(name: name)
//        allTasks.append(newTask)
        taskDataRepository.create(task: task)
    }
    
    func fetchTasks() -> [Task]? {
        return taskDataRepository.getAll()
    }
    
    func updateTask(_ task: Task) -> Bool {
        return taskDataRepository.update(task: task)
    }
    
    func deleteTask(_ task: Task) -> Bool {
        return taskDataRepository.delete(task: task)
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
