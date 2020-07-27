//
//  CoreDataRepository.swift
//  DICoreDataRealmTask
//
//  Created by Anas Bashandy on 26/7/20.
//  Copyright © 2020 Anas Bashandy. All rights reserved.
//

import Foundation
import CoreData

struct CoreDataRepository: PersistenceRepository {
    
    typealias T = CDTask

    func create(object: CDTask) {
        let cdTask = CDTask(context: CoreDataPersistenceStorage.shared.context)
        cdTask.name = object.name
        
        CoreDataPersistenceStorage.shared.saveContext()
    }
    
    func getAll() -> [CDTask]? {
        let result = CoreDataPersistenceStorage.shared.fetchManagedObject(managedObject: CDTask.self)
        
        return result
    }
    
    func update(object: CDTask) {
        
    }
    
    func delete(object: CDTask) {
        
    }
}

