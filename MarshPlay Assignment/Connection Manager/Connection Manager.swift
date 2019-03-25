//
//  Connection Manager.swift
//  MarshPlay Assignment
//
//  Created by Nakul Hindustani on 22/03/19.
//  Copyright © 2019 Nakul Hindustani. All rights reserved.
//

import Foundation

class ConnectionManager {
    
    static let instance = ConnectionManager()
    
    func callAPI(pageID: Int, success: @escaping ((_ response: AnyObject?) -> Void), failure: @escaping ((_ error: NSError?) -> Void)) {
        
        var request = URLRequest(url: URL(string: "http://www.omdbapi.com/?s=Batman&page=\(pageID)&apikey=eeefc96f")!)
        request.httpMethod = "GET"
        
        let session = URLSession.shared
        session.dataTask(with: request, completionHandler: { data, response, error -> Void in
            do {
                if let jsonData = data {
                    let json = try JSONSerialization.jsonObject(with: jsonData) as? Dictionary<String, AnyObject>
                    success(json as AnyObject)
                }
            } catch {
                print("error")
            }
        }).resume()
    }
}
