//
//  CDTaskRepository.swift
//  DICoreDataRealmTask
//
//  Created by Anas Bashandy on 27/7/20.
//  Copyright © 2020 Anas Bashandy. All rights reserved.
//

import Foundation
import CoreData

struct CDTaskRepository: TaskRepository {
    func create(task: Task) {
        let cdTask = CDTask(context: CDPersistentStorage.shared.context)
        cdTask.name = task.name
        
        CDPersistentStorage.shared.saveContext()
    }
    
    func getAll() -> [Task]? {
        let result = CDPersistentStorage.shared.fetchManagedObject(managedObject: CDTask.self)
        var tasks = [Task]()
        
        result?.forEach({ (cdTask) in
            tasks.append(cdTask.convertToTask())
        })
        
        return tasks
    }
    
    func update(task: Task) -> Bool {
        let cdTask = getCDTask(byName: task.name)
        guard cdTask != nil else { return false }
        
        cdTask?.name = task.name
        
        CDPersistentStorage.shared.saveContext()
        
        return true
    }
    
    func delete(task: Task) -> Bool {
        let cdTask = getCDTask(byName: task.name)
        guard cdTask != nil else { return false }
        
        CDPersistentStorage.shared.context.delete(cdTask!)
        
        return true
    }
    
    // MARK: Helper Methods
    
    private func getCDTask(byName name: String) -> CDTask? {
        let fetchRequest = NSFetchRequest<CDTask>(entityName: "CDTask")
        let predicate = NSPredicate(format: "name==%@", name as CVarArg)
        
        fetchRequest.predicate = predicate
        
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
