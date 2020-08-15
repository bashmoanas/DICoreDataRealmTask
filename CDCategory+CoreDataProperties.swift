//
//  CDCategory+CoreDataProperties.swift
//  DICoreDataRealmTask
//
//  Created by Anas Bashandy on 9/8/20.
//  Copyright © 2020 Anas Bashandy. All rights reserved.
//
//

import Foundation
import CoreData


extension CDCategory {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDCategory> {
        return NSFetchRequest<CDCategory>(entityName: "CDCategory")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var isExpanded: Bool
    @NSManaged public var name: String?
    @NSManaged public var toTask: Set<CDTask>?

}

// MARK: Generated accessors for toTask
extension CDCategory {

    @objc(addToTaskObject:)
    @NSManaged public func addToToTask(_ value: CDTask)

    @objc(removeToTaskObject:)
    @NSManaged public func removeFromToTask(_ value: CDTask)

    @objc(addToTask:)
    @NSManaged public func addToToTask(_ values: NSSet)

    @objc(removeToTask:)
    @NSManaged public func removeFromToTask(_ values: NSSet)

}
