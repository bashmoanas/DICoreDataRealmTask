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
    
    func update(task: Task) {
        let cdTask = getCDTask(byName: task.name)
        guard cdTask != nil else { return }
        
        cdTask?.name = task.name
        
        CDPersistentStorage.shared.saveContext()
    }
    
    func delete(task: Task) {
        let cdTask = getCDTask(byName: task.name)
        guard cdTask != nil else { return }
        
        CDPersistentStorage.shared.context.delete(cdTask!)
        CDPersistentStorage.shared.saveContext()
    }
    
    // MARK: Helper Methods
    
    private func getCDTask(byName name: String) -> CDTask? {
        let fetchRequest = NSFetchRequest<CDTask>(entityName: "CDTask")
        let predicate = NSPredicate(format: "name==%@", name)
        
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
