//
//  ViewController.swift
//  CoreDataSampleApp
//
//  Created by rahulverma on 15/8/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView : UITableView?
    
    @IBOutlet weak var nameField : UITextField?
    @IBOutlet weak var designationField : UITextField?
    @IBOutlet weak var departmentField : UITextField?
    
    private var data : [Employee] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchRecords()
        // Do any additional setup after loading the view.
    }
    
    func fetchRecords() {
        
        do {
            
            let result = try PersistentContainerClass.shared.context.fetch(Employee.fetchRequest())
            
            self.data.removeAll()
            
            self.data.append(contentsOf: result)
            
            self.tableView?.reloadData()
            
            
        } catch {
            
            print(error)
        }
        
    }
    
    @IBAction func deleteRecord(sender: AnyObject) {
        
        do {
            if let dataToDelete = try  PersistentContainerClass.shared.context.fetch(Employee.fetchRequest()).first {
                PersistentContainerClass.shared.context.delete(dataToDelete)
                try PersistentContainerClass.shared.context.save()
                print("Task deleted successfully")
                fetchRecords()
            }
        } catch {
            print("Error deleting task: \(error)")
        }
    }
    

    // MARK: IBAction
    
    @IBAction func submitBtnClicked(sender: AnyObject) {
        
        if let employee = Employee(context: PersistentContainerClass.shared.context) as? Employee {
            
            if let nameStr = nameField?.text {
                
                employee.name = nameStr
            }
            
            if let designationStr = designationField?.text {
                
                employee.designation = designationStr
            }
            
            if let departmentStr = departmentField?.text {
                
                employee.department = departmentStr
            }
            
            employee.age = 20
            
            PersistentContainerClass.shared.saveContext()
            
            fetchRecords()
        }
        
    }
    
}

extension ViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return data.count
        }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            cell.textLabel?.text = "\(data[indexPath.row].name ?? "") - \(data[indexPath.row].department ?? "") - \(data[indexPath.row].designation ?? "")"
            return cell
        }
    
}

