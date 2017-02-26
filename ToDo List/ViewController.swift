//
//  ViewController.swift
//  ToDo List
//
//  Created by Sushrut Shastri on 2017-02-25.
//  Copyright © 2017 Sushrut Shastri. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
  
    
    //Array of Task entity
    var tasks : [Task] = []
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }

    
    
    override func viewWillAppear(_ animated: Bool) {
        getData()
        
        tableView.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")! as UITableViewCell
        
        let task = tasks[indexPath.row]
        cell.textLabel?.text = task.title
        
        return cell
    }
   
    //function to get data from coreData
    func getData(){
            // To access coreData
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        // Fill the array with the tasks in the coreData database
                do{
                    tasks = try context.fetch(Task.fetchRequest())
                  }
                catch{
                        print("Oops..! Something's wrong!!!")
                     }
        
        }
    
    // Function for Swipe to Delete
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        // To access coreData
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        if editingStyle == .delete{
            let task = tasks[indexPath.row]
            context.delete(task)
            //To save data after deletion
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            //Refill and reload the Talbeview with updated Data from coreData database
            do{
                tasks = try context.fetch(Task.fetchRequest())
            }
            catch{
                print("Oops..! Something's wrong!!!")
            }
            tableView.reloadData()
        }
        
    }
    
    @IBAction func stateSwitch(_ sender: Any) {
    }
    

}

