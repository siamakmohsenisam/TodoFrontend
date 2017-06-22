//
//  LoginViewController.swift
//  TodoApp
//
//  Created by Siamak Mohseni Sam on 2017-06-16.
//  Copyright © 2017 Fatih Nayebi. All rights reserved.
//

import UIKit
import ObjectMapper
import Alamofire

class LoginViewController: UIViewController {
    
    @IBOutlet weak var username: UITextField!

    @IBOutlet weak var password: UITextField!
    
    @IBAction func register(_ sender: UIButton) {
        password.text = ""
    }
    @IBAction func btnLogin(_ sender: UIButton) {
        
        LoginManager.login(userName: username.text!, password: password.text!) {
            
            (responseData, error) in
            if let response = responseData {
                if response.success == true {
                    print(response.success)
                    let todosViewController = self.storyboard?.instantiateViewController(withIdentifier: "TodosTableViewController")
                    self.navigationController?.pushViewController(todosViewController!, animated: true)
                    
                } else {
                    print("User name and password were not correct")
                    let alert = UIAlertController(title: "Error", message: "User name and password were not correct", preferredStyle: .alert)
                    let action = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alert.addAction(action)
                    self.present(alert, animated: true, completion: nil)
                }
            } else if  error == true {
                print("Backend error")
                let alert = UIAlertController(title: "Error", message: "Something went wrong with the backend", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(action)
                self.present(alert, animated: true, completion: nil)
            }
        }
        
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let ident = segue.identifier{
            if ident == "registration" {
                if let registerView = segue.destination as? RegisterViewController{
                    registerView.delegate = self
                }
                
            }
        }
        
        
        
        
            }
//    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
//        if identifier == "logIdentifier" {
//            if username.text == "username" && password.text == "password"{
//                return true
//            }
//        }
//        return true
//    }

}

protocol RegistertionDelegate: class {
    func userRegistered(name: String)
}

extension LoginViewController: RegistertionDelegate {
    func userRegistered(name: String) {
        print("Child did something")
        username.text = name
    }
}





