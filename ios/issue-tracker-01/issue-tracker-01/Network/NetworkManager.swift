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
        request.addValue("Bearer eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ0ZXN0MiIsImlhdCI6MTcxNjM0MTY3NSwiZXhwIjoxNzE2Mzc3Njc1fQ.7U8ifNvhtCUUTN2bCSPKHvIMCryi8YkM2kaZfO_ZMyU", forHTTPHeaderField: "Authorization")
        
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
        request.addValue("Bearer eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ0ZXN0MiIsImlhdCI6MTcxNjM0MTY3NSwiZXhwIjoxNzE2Mzc3Njc1fQ.7U8ifNvhtCUUTN2bCSPKHvIMCryi8YkM2kaZfO_ZMyU", forHTTPHeaderField: "Authorization")
        
        httpManager.sendRequest(request) { _, response, error in
            guard let response = response, (200..<300).contains(response.statusCode) else {
                os_log("[ closeIssue ] : \(String(describing: error))\n\(String(describing: response?.statusCode))")
                completion(false)
                return
            }
            completion(true)
        }
    }
    
    func fetchLabels(completion: @escaping ([LabelResponse]?) -> Void) {
        guard let url = URL(string: URLDefines.labelList) else {
            completion(nil)
            return
        }
        let request = URLRequest(url: url)
        
        httpManager.sendRequest(request) { data, _, error in
            guard let data = data, error == nil else {
                os_log("[ fetchLabels ] : \(String(describing: error))")
                completion(nil)
                return
            }
            
            do {
                let labels = try JSONDecoder().decode([LabelResponse].self, from: data)
                self.prettyPrintJSON(labels)
                completion(labels)
            } catch {
                os_log("[ fetchLabels ]: \(error)")
                completion(nil)
            }
        }
    }
    
    func deleteLabel(labelId: Int, completion: @escaping (Bool) -> Void) {
        guard let url = URL(string: URLDefines.label + "/\(labelId)") else {
            completion(false)
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.delete.rawValue
        request.addValue("Bearer eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ0ZXN0MiIsImlhdCI6MTcxNjM0MTY3NSwiZXhwIjoxNzE2Mzc3Njc1fQ.7U8ifNvhtCUUTN2bCSPKHvIMCryi8YkM2kaZfO_ZMyU", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        httpManager.sendRequest(request) { _, response, error in
            guard let response = response, (200..<300).contains(response.statusCode) else {
                os_log("[ deleteLabel ] : \(String(describing: error))\n\(String(describing: response?.statusCode))")
                completion(false)
                return
            }
            completion(true)
        }
    }
    
    func updateLabel(labelId: Int, labelRequest: LabelRequest, completion: @escaping (Bool, LabelResponse?) -> Void) {
        guard let url = URL(string: URLDefines.label + "/\(labelId)") else {
            completion(false, nil)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.patch.rawValue
        request.addValue("Bearer eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ0ZXN0MiIsImlhdCI6MTcxNjM0MTY3NSwiZXhwIjoxNzE2Mzc3Njc1fQ.7U8ifNvhtCUUTN2bCSPKHvIMCryi8YkM2kaZfO_ZMyU", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let jsonData = try JSONEncoder().encode(labelRequest)
            request.httpBody = jsonData
        } catch {
            os_log("[ updateLabel ]: \(error)")
            completion(false, nil)
            return
        }
        
        httpManager.sendRequest(request) { data, response, error in
            guard let data = data, error == nil,
                  let response = response, (200..<300).contains(response.statusCode) else {
                os_log("[ updateLabel ] : \(String(describing: error?.localizedDescription))\n[ statusCode ]: \(String(describing: response?.statusCode))")
                
                completion(false, nil)
                return
            }
            
            do {
                let decodedLabel = try JSONDecoder().decode(LabelResponse.self, from: data)
                completion(true, decodedLabel)
            } catch {
                os_log("[ updateLabel ] : \(error)")
                completion(false, nil)
            }
        }
    }
    
    func createLabel(label: LabelRequest, completion: @escaping (Bool, LabelResponse?) -> Void) {
        guard let url = URL(string: URLDefines.label) else {
            completion(false, nil)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.post.rawValue
        request.addValue("Bearer eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ0ZXN0MiIsImlhdCI6MTcxNjM0MTY3NSwiZXhwIjoxNzE2Mzc3Njc1fQ.7U8ifNvhtCUUTN2bCSPKHvIMCryi8YkM2kaZfO_ZMyU", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let jsonData = try JSONEncoder().encode(label)
            request.httpBody = jsonData
        } catch {
            os_log("[ createLabel ]: \(error)")
            completion(false, nil)
            return
        }
        
        httpManager.sendRequest(request) { data, response, error in
            guard let data = data, error == nil,
                  let response = response, (200..<300).contains(response.statusCode) else {
                os_log("[ createLabel ] : \(String(describing: error?.localizedDescription))\n[ statusCode ]: \(String(describing: response?.statusCode))")
                
                completion(false, nil)
                return
            }
            do {
                let decodedLabel = try JSONDecoder().decode(LabelResponse.self, from: data)
                completion(true, decodedLabel)
            } catch {
                os_log("[ createLabel ] : \(String(describing: error))")
                completion(false, nil)
            }
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
