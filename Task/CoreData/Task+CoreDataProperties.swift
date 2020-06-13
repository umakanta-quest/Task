//
//  Task+CoreDataProperties.swift
//  Task
//
//  Created by Umakanta Sahoo on 13/06/20.
//  Copyright © 2020 Umakanta Sahoo. All rights reserved.
//
//

import Foundation
import CoreData


extension Task {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task> {
        return NSFetchRequest<Task>(entityName: "Task")
    }

    @NSManaged public var complexity: NSNumber?
    @NSManaged public var createDate: Date?
    @NSManaged public var name: String?
    @NSManaged public var status: String?
    @NSManaged public var updateDate: Date?
    
}
