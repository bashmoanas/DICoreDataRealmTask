//
//  TaskRepository.swift
//  DICoreDataRealmTask
//
//  Created by Anas Bashandy on 27/7/20.
//  Copyright © 2020 Anas Bashandy. All rights reserved.
//

import Foundation

protocol TaskRepository {
    func create(task: Task)
    func getAll() -> [Task]?
    func update(task: Task) -> Bool
    func delete(task: Task) -> Bool
}
