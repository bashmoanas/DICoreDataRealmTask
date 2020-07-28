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
    
    mutating func createTask(_ task: Task) {
        //        let newTask = Task(name: name)
        //        allTasks.append(newTask)
        taskDataRepository.create(task: task)
        allTasks.append(task)
    }
    
    func fetchTasks() -> [Task]? {
        return taskDataRepository.getAll()
    }
    
    func updateTask(_ task: Task) {
        return taskDataRepository.update(task: task)
    }
    
    mutating func deleteTask(_ task: Task) {
        guard let index = allTasks.firstIndex(of: task) else { return }
        allTasks.remove(at: index)
        taskDataRepository.delete(task: task)
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
