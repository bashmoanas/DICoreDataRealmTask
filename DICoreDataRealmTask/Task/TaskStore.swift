//
//  TaskStore.swift
//  DICoreDataRealmTask
//
//  Created by Anas Bashandy on 26/7/20.
//  Copyright © 2020 Anas Bashandy. All rights reserved.
//

import Foundation

struct TaskStore {
    
    init(taskStore: TaskRepository) {
        taskDataRepository = taskStore
    }
    
    var taskDataRepository: TaskRepository!
    
    var allTasks = [Task]()
    
    var taskCount: Int {
        return allTasks.count
    }
    
    func getTaskAt(index: Int) -> Task {
        return allTasks[index]
    }
    
    mutating func createTask(_ task: Task) {
        taskDataRepository.create(task: task)
        allTasks.append(task)
    }
    
    func fetchTasks() -> [Task]? {
        return taskDataRepository.getAll()
    }
    
    mutating func updateTask(_ task: Task) -> Bool {
        guard let index = allTasks.firstIndex(of: task) else { return false }
        
        guard taskDataRepository.update(task: task) else { return false}
        
        return true
    }
    
    mutating func deleteTask(_ task: Task) -> Bool {
        guard let index = allTasks.firstIndex(of: task) else { return false }
        
        guard taskDataRepository.delete(task: task) else { return false }
        allTasks.remove(at: index)
        
        return true
    }
    
}
