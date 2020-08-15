//
//  CDTaskRepository.swift
//  DICoreDataRealmTask
//
//  Created by Anas Bashandy on 27/7/20.
//  Copyright © 2020 Anas Bashandy. All rights reserved.
//

import Foundation
import CoreData

struct CDTaskRepository: Repository {
    
    func create(item: Task) {
        let cdTask = CDTask(context: CDPersistentStorage.shared.context)
        cdTask.id = item.id
        cdTask.name = item.name        
        
        CDPersistentStorage.shared.saveContext()
    }
    
    func getAllItems() -> [Task]? {
        let results = CDPersistentStorage.shared.fetchManagedObject(managedObject: CDTask.self)
        return results?.map { $0.convertToTask() }
    }
    
    func getItemByIdentifier(_ id: UUID) -> Task? {
        let result = getCDTask(byID: id)
        guard result != nil else { return nil }
        
        return result.map { $0.convertToTask() }
    }
    
    func update(item: Task) -> Bool {
        let cdTask = getCDTask(byID: item.id)
        guard cdTask != nil else { return false }
        
        cdTask?.name = item.name
                
        CDPersistentStorage.shared.saveContext()
        
        return true
    }
    
    func delete(item: Task) -> Bool {
        let cdTask = getCDTask(byID: item.id)
        guard cdTask != nil else { return false }
        
        CDPersistentStorage.shared.context.delete(cdTask!)
        CDPersistentStorage.shared.saveContext()
        
        return true
    }
    
    // MARK: Helper Methods
    
    private func getCDTask(byID id: UUID) -> CDTask? {
        let fetchRequest = NSFetchRequest<CDTask>(entityName: "CDTask")
        let predicate = NSPredicate(format: " id==%@ ", id as CVarArg)
        
        fetchRequest.predicate = predicate
        fetchRequest.fetchLimit = 1
        
        do {
            let result = try CDPersistentStorage.shared.context.fetch(fetchRequest).first
            guard result != nil else { return nil }
            return result
        } catch let error {
            debugPrint(error)
        }
        
        return nil
    }
}
