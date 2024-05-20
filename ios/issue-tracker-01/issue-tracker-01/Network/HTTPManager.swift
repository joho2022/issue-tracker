//
//  HTTPManager.swift
//  issue-tracker-01
//
//  Created by 조호근 on 5/13/24.
//

import Foundation

protocol HTTPManagerProtocol {
    func sendRequest(_ request: URLRequest, completion: @escaping (Data?, HTTPURLResponse?, Error?) -> Void)
}

final class HTTPManager: HTTPManagerProtocol {
    static let shared = HTTPManager()
    
    func sendRequest(_ request: URLRequest, completion: @escaping (Data?, HTTPURLResponse?, (any Error)?) -> Void) {
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                completion(data, response as? HTTPURLResponse, error)
            }
        }.resume()
    }
}
