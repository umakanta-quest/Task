//
//  Image+CoreDataProperties.swift
//  Task
//
//  Created by Umakanta Sahoo on 16/06/20.
//  Copyright © 2020 Umakanta Sahoo. All rights reserved.
//
//

import Foundation
import CoreData


extension Image {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Image> {
        return NSFetchRequest<Image>(entityName: "Image")
    }

    @NSManaged public var name: String?
    @NSManaged public var photo: Data?
    @NSManaged public var date: Date?
    @NSManaged public var task: Task?

}
