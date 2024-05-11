//
//  IssueViewModel.swift
//  issue-tracker-01
//
//  Created by 조호근 on 5/9/24.
//

import Foundation

class IssueViewModel {
    var issues: [Issue]?

    func fetchIssues(completion: @escaping () -> Void) {
        guard let url = URL(string: "http://13.125.246.130:8080/issue/list") else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Error fetching data: \(error?.localizedDescription ?? "Unknown error")")
                return
            }

            do {
                self.issues = try JSONDecoder().decode([Issue].self, from: data)
                
                let encoder = JSONEncoder()
                encoder.outputFormatting = .prettyPrinted
                let jsonData = try encoder.encode(self.issues)
                if let jsonString = String(data: jsonData, encoding: .utf8) {
                    print(jsonString)
                }
                completion()
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }.resume()
    }
}
