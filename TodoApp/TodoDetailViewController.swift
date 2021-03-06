//
//  TodoDetailViewController.swift
//  2016-06-01-codelab-frontend
//
//  Created by Fatih Nayebi on 2016-06-01.
//  Copyright © 2016 Swift-Mtl. All rights reserved.
//

import UIKit

class TodoDetailViewController: UIViewController {
    
    @IBOutlet weak var myTitle: UILabel!
    @IBOutlet weak var id: UITextField!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var detail: UITextField!
    @IBOutlet weak var notes: UITextField!
    @IBOutlet weak var myView: UIView!
    @IBOutlet weak var completed: UISwitch!
    @IBOutlet weak var cynced: UISwitch!
    
    var myState = 0
    var  toDo : TodoModel!
    
    @IBAction func btnExit(_ sender: UIButton) {
        
        dismiss(animated: true, completion: nil)
    }
    @IBAction func btnSave(_ sender: UIButton) {
        toDo = TodoModel()
        var v = TodosTableViewController()
        
        if let views = (presentingViewController?.childViewControllers) {
            
            for view in views {
                if view as? TodosTableViewController != nil {
                    v = view as! TodosTableViewController
                    break
                }
            }
        }
        
        if let myName = name.text , let myDetail = detail.text ,
            let myNotes = notes.text , let myId = id.text {
            
            guard myId != "" else {  return }
            
            toDo.name = myName
            toDo.details = myDetail
            toDo.notes = myNotes
            
            if let intId = Int (myId) {
                toDo.todoId = intId
            }
            
            if completed.isOn {
                toDo.completed = true
            }
            if cynced.isOn {
                toDo.synced = true
            }
        }
    
        //  copy toDo into backend
        
        var toDoJson = toDo.toJSON()
        toDoJson["id"] = toDo.todoId
        
        var toDoHeader = Dictionary<String, String>()
        
        for (key, value) in toDoJson {
            toDoHeader[key] = String(describing: value)
        }
        
        TodoManager.addTodo(toDoHeader as [String : AnyObject],  { (responseData, error) in
            
            if error == false {
                v.myToDo = responseData!
                v.tableView.reloadData()
            }
        })
         dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myView.layer.cornerRadius = 12
        myView.layer.masksToBounds = true
        
        if myState == 1 {
            
            myTitle.text = "Detail and update"
            id.isEnabled = false
            
            id.text = String (toDo.todoId)
            name.text = toDo.name
            detail.text = toDo.details
            notes.text = toDo.notes
            completed.setOn(toDo.completed, animated: false)
            cynced.setOn(toDo.synced, animated: false)
            myState = 0
        }
    }
}










