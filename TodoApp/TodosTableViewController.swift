//
//  TodosTableViewController.swift
//  2016-06-01-codelab-frontend
//
//  Created by Fatih Nayebi on 2016-06-01.
//  Copyright © 2016 Swift-Mtl. All rights reserved.
//

import UIKit

class TodosTableViewController: UITableViewController
{
    
    var myToDo = [TodoModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TodoManager.localTodos {
            (responseData, error) in
            if error == false {
                if let response = responseData{
                    self.myToDo = response
                    self.tableView.reloadData()
                    
                    
                    
                }
            }
        }
        navigationItem.rightBarButtonItems?.append(editButtonItem)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        if let identifire = segue.identifier ,
            let destination  = segue.destination as? TodoDetailViewController {
            if identifire == "detailIdentifire" {
                if let row = tableView.indexPathForSelectedRow {
                    destination.toDo = myToDo[row.row]
                    destination.myState = 1
                }
            }
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return myToDo.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        
        cell.textLabel?.text = myToDo[indexPath.row].name + "    "+"\(myToDo[indexPath.row].todoId)"
        
        // Configure the cell...
        
        return cell
    }
    
    
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        
        
        return true
    }
    
    
    // Override to support editing the table view.
    override  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete
        {
            deleteData(myToDo[indexPath.row])
            
            myToDo.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        } else if editingStyle == .insert {
            
        }
    }
    
    
    
    
    
}
