//
//  HTTPManager.swift
//  issue-tracker-01
//
//  Created by 조호근 on 5/13/24.
//

import Foundation
import os

final class HTTPManager {
    
    static func requestGET(url: String, completion: @escaping (Data) -> Void) {
        guard let url = URL(string: url) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, _ in
            guard let data = data else { return }
            guard let response = response as? HTTPURLResponse, (200..<300).contains(response.statusCode) else {
                if let response = response as? HTTPURLResponse {
                    os_log("[ requestGET ] : \(response.statusCode)")
                }
                return
            }
                  
            completion(data)
        }.resume()
    }
    
    static func requestPOST(url: String, encodingData: Data = Data(), completion: @escaping (Bool) -> Void) {
        guard let url = URL(string: url) else {
            completion(false)
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = HTTPMethod.post.rawValue
        urlRequest.httpBody = encodingData
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, _ in
            guard data != nil else { return }
            guard let response = response as? HTTPURLResponse, (200..<300).contains(response.statusCode) else {
                if let response = response as? HTTPURLResponse {
                    os_log("[ requestPOST ] : \(response.statusCode)")
                }
                return
            }
            
            completion(true)
        }.resume()
    }
    
    static func requestPATCH(url: String, encodingData: Data = Data(), completion: @escaping (Data) -> Void) {
        guard let url = URL(string: url) else { return }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = HTTPMethod.patch.rawValue
        urlRequest.httpBody = encodingData
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, _ in
            guard let data = data else { return }
            guard let response = response as? HTTPURLResponse, (200..<300).contains(response.statusCode) else {
                if let response = response as? HTTPURLResponse {
                    os_log("[ requestPATCH ] : \(response.statusCode.description)")
                }
                return
            }
            
            completion(data)
        }.resume()
    }
    
    static func requestDELETE(url: String, completion: @escaping (Bool) -> Void) {
        guard let url = URL(string: url) else {
            completion(false)
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = HTTPMethod.delete.rawValue
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, _ in
            guard data != nil else { return }
            guard let response = response as? HTTPURLResponse, (200..<300).contains(response.statusCode) else {
                if let response = response as? HTTPURLResponse {
                    os_log("[ requestDELETE ] : \(response.statusCode)")
                }
                return
            }
            
            completion(true)
        }.resume()
    }
}
