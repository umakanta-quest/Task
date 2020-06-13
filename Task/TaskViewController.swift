//
//  TaskViewController.swift
//  Task
//
//  Created by Umakanta Sahoo on 13/06/20.
//  Copyright © 2020 Umakanta Sahoo. All rights reserved.
//

import UIKit
import CoreData

class TaskViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    lazy var context: NSManagedObjectContext? = {
          let appDelegate = UIApplication.shared.delegate as? AppDelegate
          
          return appDelegate?.persistentContainer.viewContext
      }()
    
    private lazy var fetchedResultsController: NSFetchedResultsController<Task> = {
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: #keyPath(Task.createDate), ascending: true)]

        let controller = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                    managedObjectContext: context!,
                                                    sectionNameKeyPath: nil, cacheName: nil)
        controller.delegate = self
    
        do {
            try controller.performFetch()
        } catch {
            fatalError("###\(#function): Failed to performFetch: \(error)")
        }
        return controller
    }()
    
    private lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.setLocalizedDateFormatFromTemplate("EEEE, MMM d, yyyy")
        return dateFormatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Tasks"
        // Do any additional setup after loading the view.
        
        self.navigationItem.setHidesBackButton(true, animated: false)
        
        setupTableView()
    }
    
    func setupTableView() {
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        
        tableView.register(UINib.init(nibName: "TaskTableViewCell", bundle: nil), forCellReuseIdentifier: "TaskTableViewCell")
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

// MARK: - NSFetchedResultsControllerDelegate
//
extension TaskViewController: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.reloadData()
    }
}


extension TaskViewController: UITableViewDataSource, UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultsController.sections?[section].numberOfObjects ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TaskTableViewCell", for: indexPath) as? TaskTableViewCell else {
            fatalError("###\(#function): Failed to dequeue a Cell.")
        }
        
        let task = fetchedResultsController.object(at: indexPath)
        cell.nameLabel.text = task.name
        if let publishDate = task.createDate {
            cell.createDateLabel.text = "Created on: " + dateFormatter.string(from: publishDate)
        }
        
        cell.stausLabel.text = task.status
        
        cell.complexityLabel.text = task.fetchComplexityLevel(task.complexity!) as String
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0  
    }
    

}
