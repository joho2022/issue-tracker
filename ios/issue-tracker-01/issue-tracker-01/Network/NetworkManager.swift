//
//  NetworkManager.swift
//  issue-tracker-01
//
//  Created by 조호근 on 5/13/24.
//

import Foundation
import os

class NetworkManager {
    static let shared = NetworkManager()
    
    func fetchIssues(completion: @escaping ([Issue]?) -> Void) {
        HTTPManager.requestGET(url: URLDefines.issueList) { data in
            do {
                let issues = try JSONDecoder().decode([Issue].self, from: data)
                
                let encoder = JSONEncoder()
                encoder.outputFormatting = .prettyPrinted
                if let jsonData = try? encoder.encode(issues),
                   let jsonString = String(data: jsonData, encoding: .utf8) {
                    print(jsonString)
                }
                
                DispatchQueue.main.async {
                    completion(issues)
                }
            } catch {
                os_log("[ fetchIssues ] : \(error)")
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }
    }
    
    func deleteIssue(issueId: Int, completion: @escaping (Bool) -> Void) {
        let url = URLDefines.issue + "/\(issueId)"
        
        HTTPManager.requestDELETE(url: url) { success in
            DispatchQueue.main.async {
                completion(success)
            }
        }
    }
    
    func closeIssue(issueId: Int, completion: @escaping (Bool) -> Void) {
         let url = URLDefines.issue + "/\(issueId)/close"
        
        HTTPManager.requestPOST(url: url) { success in
            DispatchQueue.main.async {
                completion(success)
            }
        }
    }
}
