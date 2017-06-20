//
//  LoginManager.swift
//  TodoApp
//
//  Created by Siamak Mohseni Sam on 2017-06-20.
//  Copyright © 2017 Fatih Nayebi. All rights reserved.
//

import Foundation
import ObjectMapper
import RealmSwift
import Alamofire

class LoginManager {
    
    // 1 : if we have class login
    
    class func addLogin(_ requestParameters: [String: String]? = nil , _ completion:@escaping (_ responseData:Login?, _ error: Bool?) -> ()) {
        
        let url = URL(string: "http://localhost:8080/postLogin")!
        WebServiceManger.sendRequest(requestHeaders: requestParameters! , url: url, requestMethod: .post, responseType: Login.self) {
            (responseData:Login?, error: Bool?) -> Void in
            //     print(responseData!)
            completion(responseData, false)
        }
    }
    
    class func toLogin(_ requestParameters: [String: String]? = nil ,_ completion: @escaping (_ responseData:Login?, _ error: Bool?) -> ()) {
        
        let url = URL(string: "http://localhost:8080/login")!
        WebServiceManger.sendRequest(requestHeaders: requestParameters!, url: url, requestMethod: .get, responseType: Login.self) {
            (responseData: Login?, error: Bool?) -> Void in
            //   print(responseData!)
            completion(responseData, false)
        }
    }

    
    // 2 : if we don't have class login
    
    
    class func login(userName: String,
                     password: String,
                     _ completion: @escaping (_ responseData: LoginResponse?, _ error: Bool?) -> ()) {
        
        let url = URL(string: "http://localhost:8080/login")!
        
        let headers: HTTPHeaders = [
            "userName": userName,
            "password": password
        ]
        
        WebServiceManger.sendRequest(requestHeaders: headers,
                                     url: url,
                                     requestMethod: .get,
                                     responseType: LoginResponse.self) {
                                        (responseData: LoginResponse?, error: Bool?) in
                                        completion(responseData, error)
        }
    }
    
    
}




