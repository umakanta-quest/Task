//
//  Task+CoreDataClass.swift
//  Task
//
//  Created by Umakanta Sahoo on 13/06/20.
//  Copyright © 2020 Umakanta Sahoo. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Task)
public class Task: NSManagedObject {
    
    func fetchComplexityLevel(_ complexity: NSNumber) -> NSString {
        
        let how = SampleData.Complexity(rawValue: Int(truncating: complexity))
        switch how {
        case .easy:
            return "Easy"
        case .hard:
            return "Hard"
        case .average:
            return "Average"
        default:
            return "Not Specified"
        }
    }
}
