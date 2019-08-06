//
//  ToDoItem+CoreDataProperties.swift
//  
//
//  Created by Michał Jarosz on 06/08/2019.
//
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension ToDoItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ToDoItem> {
        return NSFetchRequest<ToDoItem>(entityName: "ToDoItem")
    }

    @NSManaged public var completed: Bool
    @NSManaged public var date_date: Date?
    @NSManaged public var date_str: String?
    @NSManaged public var important: Bool
    @NSManaged public var name: String?
    @NSManaged public var todo_description: String?

}
