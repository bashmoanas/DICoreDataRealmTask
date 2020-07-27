//
//  CDTask+CoreDataProperties.swift
//  DICoreDataRealmTask
//
//  Created by Anas Bashandy on 27/7/20.
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
    
    // MARK: - Helper Methods
    
    func convertToTask() -> Task {
        return Task(name: self.name!)
    }

}
