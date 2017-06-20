//
//  WebServiceManager.swift
//  2016-06-01-codelab-frontend
//
//  Created by Fatih Nayebi on 2016-06-01.
//  Copyright © 2016 Swift-Mtl. All rights reserved.
//

import Foundation
import ObjectMapper
import Alamofire
import AlamofireObjectMapper

class WebServiceManger {
    
    class func sendRequest<T: Mappable>(
        
        _ requestParameters: [String: AnyObject]? = nil,
        url: URL,
        requestMethod: Alamofire.HTTPMethod,
        responseType: T.Type,
        completion: @escaping (_ responseData: [T]?, _ error: Bool?) -> Void){
        
        // To execute in a different thread than main thread:
        let queue = DispatchQueue(label: "manager-response-queue", attributes: DispatchQueue.Attributes.concurrent)
        
        // Alamofire web service call:
        
        
        let dataRequest = Alamofire.request (
            url,
            method: requestMethod,
            parameters: nil,
            encoding : JSONEncoding.default,
            headers: requestParameters as? [String:String])
        
        dataRequest.responseArray(queue: queue, completionHandler: {
            (response: DataResponse<[T]>) in
            
            if let mappedModel = response.result.value {
                DispatchQueue.main.async  {
                    // Save the data to DB:
                    saveData(mappedModel)
                    // callback with the data
                    completion(mappedModel, nil)
                }
            }
        })
        
    }
    
    
    class func sendRequest<T: Mappable>(
        requestHeaders: HTTPHeaders,
        url: URL,
        requestMethod: Alamofire.HTTPMethod,
        responseType: T.Type,
        completion: @escaping (_ responseData: T?, _ error: Bool?) -> Void) {
        
        let queue = DispatchQueue(label: "manager-response-queue", attributes: DispatchQueue.Attributes.concurrent)
        
        
        let request = Alamofire.request(url, method: requestMethod, parameters: nil, encoding: URLEncoding.default, headers: requestHeaders)
        
        request.responseObject(queue: queue){
            (response: DataResponse<T>) in
            
            print(response.request!)  // original URL request
            print(response.response!) // URL response
            print(response.result)    // result of response serialization
            
            if let mappedModel = response.result.value {
                DispatchQueue.main.async  {
                    // callback with the data
                    completion(mappedModel, nil)
                }
            }
        }
        
    }
    class func sendRequest(
        requestHeaders: HTTPHeaders,
        url: URL,
        requestMethod: Alamofire.HTTPMethod,
        responseType: Any.Type,
        completion: @escaping (_ responseData: Any?, _ error: Bool?) -> Void) {
        
        let queue = DispatchQueue(label: "manager-response-queue", attributes: DispatchQueue.Attributes.concurrent)
        
        
        let request = Alamofire.request(url, method: requestMethod, parameters: nil, encoding: URLEncoding.default, headers: requestHeaders)
        
        request.responseJSON(queue: queue){
            (response: DataResponse<Any>) in
            
            print(response.request!)  // original URL request
            print(response.response!) // URL response
            print(response.result)    // result of response serialization
            
            if let mappedModel = response.result.value {
                DispatchQueue.main.async  {
                    // callback with the data
                    completion(mappedModel, nil)
                }
            }
        }
        
    }

}


