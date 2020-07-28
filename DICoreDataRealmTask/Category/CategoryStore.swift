//
//  CategoryStore.swift
//  DICoreDataRealmTask
//
//  Created by Anas Bashandy on 28/7/20.
//  Copyright © 2020 Anas Bashandy. All rights reserved.
//

import Foundation

struct CategoryStore {
        
    var allCategories = [Category]()
    
    var taskCount: Int {
        return allCategories.count
    }
    
    func getCategoryAt(index: Int) -> Category {
        return allCategories[index]
    }
    
    mutating func createCategory(_ category: Category) {
        allCategories.append(category)
    }
    
//    func fetchTasks() -> [Task]? {
//        return taskDataRepository.getAll()
//    }
    
//    mutating func updateTask(_ task: Task) -> Bool {
//        guard let index = allTasks.firstIndex(of: task) else { return false }
//
//        guard taskDataRepository.update(task: task) else { return false}
//
//        return true
//    }
    
//    mutating func deleteTask(_ task: Task) -> Bool {
//        guard let index = allTasks.firstIndex(of: task) else { return false }
//        
//        guard taskDataRepository.delete(task: task) else { return false }
//        allTasks.remove(at: index)
//        
//        return true
//    }
    
}
