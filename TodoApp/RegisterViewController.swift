//
//  RegisterViewController.swift
//  TodoApp
//
//  Created by Siamak Mohseni Sam on 2017-06-22.
//  Copyright © 2017 Fatih Nayebi. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController
{

    weak var delegate: RegistertionDelegate?
   
    @IBOutlet weak var userName: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    @IBAction func registerButton(_ sender: UIButton) {
    
    
    let login = Login()
    
    if let myName = userName.text , let myPass = password.text {
        
        
        login.userName = myName
        login.password = myPass

    let loginJson = login.toJSON()
    
    var loginHeader = Dictionary<String, String>()
   
    for (key, value) in loginJson {
    loginHeader[key] = String(describing: value)
    }
    
    LoginManager.addLogin(loginHeader ,  { (responseData, error) in
    
    if error == false {
    
       
        
        }
    })

     self.delegate?.userRegistered(name: myName)
   
    
    
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

  


}







