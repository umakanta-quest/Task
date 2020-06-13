//
//  SampleData.swift
//  Task
//
//  Created by Umakanta Sahoo on 13/06/20.
//  Copyright © 2020 Umakanta Sahoo. All rights reserved.
//

import Foundation
import CoreData


struct SampleData {
    enum Complexity: Int {
        case easy = 0
        case average
        case hard
    }
    
    enum Status {
        case notStarted
        case started
        case inProgress
        case finished
        
        var description: String {
            switch self {
            case .notStarted:
                return "Not Started"
            case .started:
                return "Started"
            case .inProgress:
                return "Progress"
            case .finished:
                return "Finished"
            }
        }
    }
    
    
    static private let sampleTasks = [["taskName":"Request OD", "complexity": Complexity.easy, "status": Status.finished.description, "creatteDate": Date(), "updateDate": Date()],
                                      ["taskName":"Need to fill QAMS", "complexity": Complexity.average, "status": Status.inProgress.description, "creatteDate": Date(), "updateDate": Date()],
    ["taskName":"Need to fill Time Sheet - IPMS", "complexity": Complexity.hard, "status": Status.notStarted.description, "creatteDate": Date(), "updateDate": Date()],
    ["taskName":"Submit Time Sheet", "complexity": Complexity.average, "status": Status.notStarted.description, "creatteDate": Date(), "updateDate": Date()],
    ["taskName":"Attend Session", "complexity": Complexity.average, "status": Status.started.description, "creatteDate": Date(), "updateDate": Date()]
    ]
    
    
    static private func generateSingleTask(with data: Dictionary<String, Any>, context: NSManagedObjectContext) {
        
        let newTask = Task(context: context)
        
        newTask.name = data["taskName"] as? String
        if let complexity = data["complexity"] as? Complexity {
            newTask.complexity = NSNumber(value: complexity.rawValue)
        }
        newTask.status = data["status"] as? String
        newTask.createDate = (data["creatteDate"] as? Date)?.format()
        newTask.updateDate = (data["updateDate"] as? Date)?.format()
        
    }
    
    static func generateSampleDataIfNeeded(context: NSManagedObjectContext) {
        
        context.perform {
            guard let number = try? context.count(for: Task.fetchRequest()), number == 0 else {
                return
            }
            
            for task in sampleTasks {
                generateSingleTask(with: task, context: context)
            }
            
            do {
                try context.save()
            }
            catch let err {
                print("Error: \(err.localizedDescription)")
            }
        }
    }
}


extension Date {
    /**
     Formats a Date

     - parameters format: (String) for eg dd-MM-yyyy hh-mm-ss
     */
    func format(format:String = "dd MMM, yyyy hh:mm:ss") -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        let dateString = dateFormatter.string(from: self)
        if let newDate = dateFormatter.date(from: dateString) {
            return newDate
        } else {
            return self
        }
    }
}
