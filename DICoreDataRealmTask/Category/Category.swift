//
//  Category.swift
//  DICoreDataRealmTask
//
//  Created by Anas Bashandy on 28/7/20.
//  Copyright © 2020 Anas Bashandy. All rights reserved.
//

import Foundation

class Category: Equatable {
    var id: UUID
    var name: String
    var isExpanded: Bool
    
    var tasks: [Task]?
    
    init(id: UUID, name: String, isExpanded: Bool, tasks: [Task]?) {
        self.id = id
        self.name = name
        self.isExpanded = isExpanded
        self.tasks = tasks
    }
    
    static func ==(lhs: Category, rhs: Category) -> Bool {
        return lhs.id == rhs.id
    }
}
