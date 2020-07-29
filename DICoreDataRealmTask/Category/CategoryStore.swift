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
    }
    
    func fetchCategories() -> [Category]? {
        return nil
    }
    
    func fetchCategoryByID(_ id: UUID) -> Category? {
        return nil
    }
    
    @discardableResult mutating func updateCategory(_ category: Category) -> Bool {
        return false
    }
    
    @discardableResult mutating func deleteCategory(_ category: Category) -> Bool {
//        guard let index = allTasks.firstIndex(of: task) else { return false }
//        allTasks.remove(at: index)
        
        return false
    }
    
}
