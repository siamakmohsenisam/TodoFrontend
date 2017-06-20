//
//  Login.swift
//  TodoApp
//
//  Created by Siamak Mohseni Sam on 2017-06-20.
//  Copyright © 2017 Fatih Nayebi. All rights reserved.
//

import Foundation
import ObjectMapper
import RealmSwift


class Login: Object, Mappable {
    
    dynamic var userName: String = ""
    dynamic var password: String = ""
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    override class func primaryKey() -> String {
        return "userName"
    }
    
    func mapping(map: Map) {
        userName <- map["userName"]
        password <- map["password"]
            }
}







