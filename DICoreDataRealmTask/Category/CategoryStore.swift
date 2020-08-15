//
//  CategoryStore.swift
//  DICoreDataRealmTask
//
//  Created by Anas Bashandy on 28/7/20.
//  Copyright © 2020 Anas Bashandy. All rights reserved.
//

import Foundation

class CategoryStore {
    
    var categoryDataRepository = CDCategoryRepository()
    
    var allCategories = [Category]()
    
    var categoryCount: Int {
        return allCategories.count
    }
    
    func getCategoryAt(index: Int) -> Category {
        return allCategories[index]
    }
    
    func createCategory(_ category: Category) {
//        allCategories.append(category)
        categoryDataRepository.create(item: category)
    }
    
    func fetchCategories() -> [Category]? {
        return categoryDataRepository.getAllItems()
    }
    
    func fetchCategoryByID(_ id: UUID) -> Category? {
        return categoryDataRepository.getItemByIdentifier(id)
    }
    
    @discardableResult func updateCategory(_ category: Category) -> Bool {
        return categoryDataRepository.update(item: category)
    }
    
    @discardableResult func deleteCategory(_ category: Category) -> Bool {
        return categoryDataRepository.delete(item: category)
    }
    
}
