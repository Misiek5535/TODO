//
//  ToDoItem+CoreDataProperties.swift
//  
//
//  Created by Michał Jarosz on 26/07/2019.
//
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension ToDoItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ToDoItem> {
        return NSFetchRequest<ToDoItem>(entityName: "ToDoItem")
    }

    @NSManaged public var name: String?

}
