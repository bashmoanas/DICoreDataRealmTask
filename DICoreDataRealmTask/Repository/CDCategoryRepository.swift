//
//  CDCategoryRepository.swift
//  DICoreDataRealmTask
//
//  Created by Anas Bashandy on 29/7/20.
//  Copyright © 2020 Anas Bashandy. All rights reserved.
//

import Foundation
import CoreData

struct CDCategoryRepository: Repository {
    func create(item: Category) {
        let cdCategory = CDCategory(context: CDPersistentStorage.shared.context)
        cdCategory.id = item.id
        cdCategory.name = item.name
        cdCategory.isExpanded = item.isExpanded
        
        if item.tasks != nil && item.tasks?.count != 0 {
            
            var tasksSet = Set<CDTask>()
            item.tasks?.forEach({ (task) in
                let cdTask = CDTask(context: CDPersistentStorage.shared.context)
                cdTask.id = task.id
                cdTask.name = task.name
                
                tasksSet.insert(cdTask)
            })
            
            cdCategory.toTask = tasksSet
        }
        
        CDPersistentStorage.shared.saveContext()
    }
    
    func getAllItems() -> [Category]? {
        let categories = CDPersistentStorage.shared.fetchManagedObject(managedObject: CDCategory.self)
        guard categories != nil && categories?.count != 0 else {return nil}
        
        let results = categories?.map { $0.convertToCategory() }
        
        return results
    }
    
    func getItemByIdentifier(_ id: UUID) -> Category? {
        let category = getCdCategory(byId: id)
        guard category != nil else {return nil}

        return (category?.convertToCategory())!
    }
    
    @discardableResult
    func update(item: Category) -> Bool {
        let category = getCdCategory(byId: item.id)
        guard category != nil else {return false}
        
        category?.name = item.name
        category?.isExpanded = item.isExpanded
        
        if item.tasks != nil && item.tasks?.count != 0 {
            
            var tasksSet = Set<CDTask>()
            item.tasks?.forEach({ (task) in
                let cdTask = CDTask(context: CDPersistentStorage.shared.context)
                cdTask.id = task.id
                cdTask.name = task.name
                
                tasksSet.insert(cdTask)
            })
            
            category?.toTask = tasksSet
        }
        
        CDPersistentStorage.shared.saveContext()
        return true
    }
    
    func delete(item: Category) -> Bool {
        let cdCategory = getCdCategory(byId: item.id)
        guard cdCategory != nil else {return false}

        CDPersistentStorage.shared.context.delete(cdCategory!)
        CDPersistentStorage.shared.saveContext()

        return true
    }
    
    private func getCdCategory(byId id: UUID) -> CDCategory? {
        let fetchRequest = NSFetchRequest<CDCategory>(entityName: "CDCategory")
        let predicate = NSPredicate(format: "id==%@", id as CVarArg)
        
        fetchRequest.predicate = predicate
        fetchRequest.fetchLimit = 1
        
        do {
            let result = try CDPersistentStorage.shared.context.fetch(fetchRequest).first
            guard result != nil else {return nil}
            return result
        } catch let error {
            debugPrint(error)
        }
        return nil
        
        
    }
    
}
