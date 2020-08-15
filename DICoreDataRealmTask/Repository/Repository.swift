//
//  TaskRepository.swift
//  DICoreDataRealmTask
//
//  Created by Anas Bashandy on 27/7/20.
//  Copyright © 2020 Anas Bashandy. All rights reserved.
//

import Foundation

protocol Repository {
    
    associatedtype T
    
    func create(item: T)
    func getAllItems() -> [T]?
    func getItemByIdentifier(_ identifier: UUID) -> T?
    func update(item: T) -> Bool
    func delete(item: T) -> Bool
}
