//
//  TaskStore.swift
//  DICoreDataRealmTask
//
//  Created by Anas Bashandy on 26/7/20.
//  Copyright © 2020 Anas Bashandy. All rights reserved.
//

import Foundation

class TaskStore {
    
    var taskDataRepository = CDTaskRepository()
    
    var allTasks = [Task]()
    
    var taskCount: Int {
        return allTasks.count
    }
    
    func getTaskAt(index: Int) -> Task {
        return allTasks[index]
    }
    
    func createTask(_ task: Task) {
        allTasks.append(task)
        taskDataRepository.create(item: task)
    }
    
    func fetchTasks() -> [Task]? {
        return taskDataRepository.getAllItems()
    }
    
    func fetchTaskByID(_ id: UUID) -> Task? {
        return taskDataRepository.getItemByIdentifier(id)
    }
    
    @discardableResult func updateTask(_ task: Task) -> Bool {
        return taskDataRepository.update(item: task)
    }
    
    @discardableResult func deleteTask(_ task: Task) -> Bool {
        guard let index = allTasks.firstIndex(of: task) else { return false }
        allTasks.remove(at: index)
        
        return taskDataRepository.delete(item: task)
    }
    
}
