//
//  Category.swift
//  DICoreDataRealmTask
//
//  Created by Anas Bashandy on 28/7/20.
//  Copyright © 2020 Anas Bashandy. All rights reserved.
//

import Foundation

struct Category {
    var id: UUID
    var name: String
    var tasks: [Task]
}
