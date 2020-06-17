//
//  DetailViewController.swift
//  Task
//
//  Created by Umakanta Sahoo on 16/06/20.
//  Copyright © 2020 Umakanta Sahoo. All rights reserved.
//

import UIKit
import CoreData

class DetailViewController: UIViewController {
    
    var task: Task?
    
    @IBOutlet weak var captureButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    lazy var context: NSManagedObjectContext? = {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        return appDelegate?.persistentContainer.viewContext
    }()
    
    private lazy var fetchedResultsController: NSFetchedResultsController<Image> = {
        
        guard let context = self.context else {
            fatalError("MOC is nil")
        }
        
        guard let currentTask = self.task else {
            fatalError("CurrentTask is nil")
        }
        
        let fetchRequest: NSFetchRequest<Image> = Image.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: #keyPath(Image.date), ascending: true)]
        fetchRequest.predicate = NSPredicate(format: "task == %@", currentTask)
        
        let controller = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                    managedObjectContext: context,
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
    
    //MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Submit", style: .done, target: self, action: #selector(submit))

        setupTableView()
    }
    
    @objc func submit() {
        
        let images = fetchedResultsController.fetchedObjects
        if let images = images {
            let newArray = images.map { $0.name }
            
            let allText = newArray.reduce("") { $0 + ", " + $1! }
            /*let allText = newArray.reduce( "", { x, y in
                x + ", " + y!
            })*/
            //let message = allText.trimmingCharacters(in: .whitespacesAndNewlines)
            let trimmedStr = allText.trimmingCharacters(in: .punctuationCharacters).trimmingCharacters(in: .whitespacesAndNewlines)
            let message = (trimmedStr == kEmptyString ? "Task": ("Task with attachment (" + trimmedStr + ")")) + " submitted."
            let alert = UIAlertController(title: "Wow!" , message: message, preferredStyle: .alert)
                       
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (_) in
                self.navigationController?.popViewController(animated: true)
            }))
            self.present(alert, animated: true, completion: nil)
            
        }
       
    }
    
    func setupTableView() {
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView()
        
        //tableView.register(UINib.init(nibName: "ImageTableViewCell", bundle: nil), forCellReuseIdentifier: "ImageTableViewCell")
    }
    override func viewDidLayoutSubviews() {
        captureButton.backgroundColor = .lightGray
        captureButton.layer.cornerRadius = (captureButton.frame.height/2)
        captureButton.layer.borderWidth = 10
        captureButton.layer.borderColor = UIColor.gray.cgColor
    }
    
    
    @IBAction func captureButtonAction(_ sender: UIButton) {
        ImagePickerManager().pickImage(self) { (image) in
            // Save image here....
            if let imageData = image.pngData() {
                
                let alert = UIAlertController(title: "Nice!" , message: "Give a name to your image", preferredStyle: .alert)
                
                alert.addTextField { (textField) in
                    textField.placeholder = "Enter a name"
                    textField.autocapitalizationType = .words
                }
                
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
                    let textField = alert?.textFields![0]
                    let text = textField?.text == kEmptyString ? "Task Image" : textField?.text
                    
                    if let context = self.context {
                        let newImage = Image(context: context)
                        
                        newImage.name = text
                        newImage.date = Date().format()
                        newImage.photo = imageData
                        newImage.task = self.task
                        
                        do {
                            try context.save()
                        }
                        catch let err {
                            print("Error: \(err.localizedDescription)")
                        }
                    }
                }))
                
                self.present(alert, animated: true, completion: nil)
                
            }
        }
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

extension DetailViewController: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.reloadData()
    }
}



// MARK: - UITableViewDataSource, UITableViewDelegate
//
extension DetailViewController: UITableViewDataSource, UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultsController.sections?[section].numberOfObjects ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ImageTableViewCell", for: indexPath) as? ImageTableViewCell else {
            fatalError("###\(#function): Failed to dequeue a Cell.")
        }
        
        cell.delegate = self
        let image = fetchedResultsController.object(at: indexPath)
        cell.nameLabel.text = image.name
        if let publishDate = image.date {
            cell.createDateLabel.text = "Created on: " + dateFormatter.string(from: publishDate)
        }
        
        if let imageData = image.photo, let image = UIImage(data: imageData) {
            cell.taskImageView.image = image
        }
        
        cell.deleteButton.tag = indexPath.row
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0
    }
    

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("didSelectRowAt")
    }
}


// MARK: - ImageTableViewCellDelegate
//
extension DetailViewController: ImageTableViewCellDelegate {
    func ImageTableViewCellDelegate(_ cell: ImageTableViewCell, deleteButtonAction sender: UIButton) {
        
        // Fetch Record
        let record = fetchedResultsController.object(at: IndexPath(row: sender.tag, section: 0))
         
        if let record = record as? NSManagedObject {
            
            let alert = UIAlertController(title: "Oops!" , message: "Are you sure?", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Delete", style: .default, handler: { (_) in
                // Delete Record
                guard let context = self.context else {
                    fatalError("MOC is nil")
                }
                
                context.delete(record)
                
                do {
                    try context.save()
                }
                catch let err {
                    print("Error: \(err.localizedDescription)")
                }
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
            
        }
    }
    
}
