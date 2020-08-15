//
//  CDManagedObjects+Extension.swift
//  DICoreDataRealmTask
//
//  Created by Anas Bashandy on 29/7/20.
//  Copyright © 2020 Anas Bashandy. All rights reserved.
//

import Foundation

extension CDCategory {
    func convertToCategory() -> Category {
        return Category(id: self.id!, name: self.name!, isExpanded: self.isExpanded, tasks: self.convertToTasks())
    }
    
    private func convertToTasks() -> [Task]? {
        guard self.toTask != nil && self.toTask?.count != 0 else { return nil }
        
        var tasks = [Task]()
                
        self.toTask?.forEach({ (cdTask) in
            tasks.append(cdTask.convertToTask())
        })
        
        return tasks
    }
}

extension CDTask {
    func convertToTask() -> Task {
        return Task(id: self.id!, name: self.name!)
    }
}
