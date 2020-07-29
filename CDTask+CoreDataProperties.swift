//
//  CDTask+CoreDataProperties.swift
//  DICoreDataRealmTask
//
//  Created by Anas Bashandy on 29/7/20.
//  Copyright © 2020 Anas Bashandy. All rights reserved.
//
//

import Foundation
import CoreData


extension CDTask {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDTask> {
        return NSFetchRequest<CDTask>(entityName: "CDTask")
    }

    @NSManaged public var name: String?
    @NSManaged public var id: UUID?
    
    func convertToTask() -> Task {
        return Task(id: self.id ?? UUID(), name: self.name!)
    }
}
