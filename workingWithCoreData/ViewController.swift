//
//  ViewController.swift
//  workingWithCoreData
//
//  Created by Johann Kerr on 3/15/17.
//  Copyright © 2017 Johann Kerr. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UITableViewController {
    
    
    let store = CoreDataStore.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        self.store.getTasks()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.store.savedTaskArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath)
        
        let task = self.store.savedTaskArray[indexPath.row]
        cell.backgroundColor = UIColor.getRandomColor()
        if let content = task.content {
            cell.textLabel?.text = content
        }
        
        
        return cell
    }
    
    
    @IBAction func addBtnPressed(_ sender: Any) {
        let alertController = UIAlertController(title: "Add Task", message: nil, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { (action) in
            print("Ok pressed")
            
            
            if let textField = alertController.textFields?[0] {
                if let text = textField.text {
                    print(text)
                   
                    self.store.saveTask(text)
                    self.tableView.reloadData()
                }
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive) { (action) in
            print("Cancel pressed")
        }
        alertController.addTextField { (textField) in
            textField.placeholder = "Task"
        }
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    
   

}


extension UIColor {
    class func getRandomColor() -> UIColor {
        let red = CGFloat(drand48())
        let green = CGFloat(drand48())
        let blue = CGFloat(drand48())
        
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
        
    }
}
