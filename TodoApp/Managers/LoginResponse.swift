//
//  LoginResponse.swift
//  TodoApp
//
//  Created by Siamak Mohseni Sam on 2017-06-20.
//  Copyright © 2017 Fatih Nayebi. All rights reserved.
//

import Foundation
import ObjectMapper
import Alamofire
import ObjectMapper

class LoginResponse: Mappable {
    
    var success: Bool = false
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        success <- map["success"]
    }
}
