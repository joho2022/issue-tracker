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
    private let httpManager: HTTPManagerProtocol
    
    init(httpManager: HTTPManagerProtocol = HTTPManager.shared) {
        self.httpManager = httpManager
    }
    
    func fetchIssues(completion: @escaping ([Issue]?) -> Void) {
        guard let url = URL(string: URLDefines.issueList) else {
            completion(nil)
            return
        }
        
        let request = URLRequest(url: url)
        
        httpManager.sendRequest(request) { data, _, error in
            guard let data = data, error == nil else {
                os_log("[ fetchIssues ] : \(String(describing: error))")
                completion(nil)
                return
            }
            
            do {
                let issues = try JSONDecoder().decode([Issue].self, from: data)
                self.prettyPrintJSON(issues)
                completion(issues)
            } catch {
                os_log("[ fetchIssues ] : \(error)")
                completion(nil)
            }
        }
    }
    
    func fetchIssueDetail(issueId: Int, completion: @escaping (IssueDetail?) -> Void) {
        guard let url = URL(string: URLDefines.issue + "/\(issueId)") else {
            completion(nil)
            return
        }
        let request = URLRequest(url: url)
        
        httpManager.sendRequest(request) { data, _, error in
            guard let data = data, error == nil else {
                os_log("[ fetchIssueDetail ] : \(String(describing: error))")
                completion(nil)
                return
            }
            
            do {
                let issueDetail = try JSONDecoder().decode(IssueDetail.self, from: data)
                self.prettyPrintJSON(issueDetail)
                completion(issueDetail)
                return
            } catch {
                os_log("[ fetchIssueDetail ] : \(error)")
                completion(nil)
            }
        }
    }
    
    func deleteIssue(issueId: Int, completion: @escaping (Bool) -> Void) {
        guard let url = URL(string: URLDefines.issue + "/\(issueId)") else {
            completion(false)
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.delete.rawValue
        
        httpManager.sendRequest(request) { _, response, error in
            guard let response = response, (200..<300).contains(response.statusCode) else {
                os_log("[ deleteIssue ] : \(String(describing: error))")
                completion(false)
                return
            }
            completion(true)
        }
    }
    
    func closeIssue(issueId: Int, completion: @escaping (Bool) -> Void) {
        guard let url = URL(string: URLDefines.issue + "/\(issueId)/close") else {
            completion(false)
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.post.rawValue
        
        httpManager.sendRequest(request) { _, response, error in
            guard let response = response, (200..<300).contains(response.statusCode) else {
                os_log("[ closeIssue ] : \(String(describing: error))")
                completion(false)
                return
            }
            completion(true)
        }
    }
    
    private func prettyPrintJSON<T: Encodable>(_ item: T) {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        do {
            let jsonData = try encoder.encode(item)
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                print(jsonString)
            }
        } catch {
            os_log("[ prettyPrintJSON ] : \(error)")
        }
    }
}
