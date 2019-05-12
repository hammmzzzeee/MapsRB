//
//  NetworkCallsHandler.swift
//  MapsRB
//
//  Created by HAMZA on 10/05/2019.
//  Copyright © 2019 HAMZA. All rights reserved.
//

import Foundation

class ApiService
{
    static func getPostString(params:[String:Any]) -> String
    {
        var data = [String]()
        for(key, value) in params
        {
            data.append(key + "=\(value)")
        }
        return data.map { String($0) }.joined(separator: "&")
    }
    
    static func callPost(url:URL, params:[String:Any], finish: @escaping ((message:String, data:Data?)) -> Void)
    {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let postString = self.getPostString(params: params)
        request.httpBody = postString.data(using: .utf8)
        
        var result:(message:String, data:Data?) = (message: "Fail", data: nil)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if(error != nil)
            {
                result.message = "Fail Error not null : \(error.debugDescription)"
            }
            else
            {
                result.message = "Success"
                result.data = data
            }
            
            finish(result)
        }
        task.resume()
    }
    
    static func getUsers(finish: @escaping (_ arrUser:[User]) -> Void){
        let url = URL(string: getAllLocations)!
        var result:(message:String, data:Data?) = (message: "Fail", data: nil)

        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data else { return }
            print(String(data: data, encoding: .utf8)!)
            
            result.message = "Success"
            result.data = data
           
            var arrUsers = [User]()

            // parsing data
            do
            {
                
                    let userObject = (try? JSONSerialization.jsonObject(with: data, options: []))
                    
                    let content = userObject as! NSArray
                for user in content
                    {
                        let dict = user as! NSDictionary
                        
                        let user = User()
                        user.id = dict["id"] as! Int
                        user.username = dict["username"] as! String
                        user.latitude = dict["lat"] as! NSNumber
                        user.longitude = dict["lng"] as! NSNumber
                        
                        arrUsers.append(user)
                    }
                    
                
            }
         
        finish(arrUsers)
        }
        
        task.resume()
    }
    
}
