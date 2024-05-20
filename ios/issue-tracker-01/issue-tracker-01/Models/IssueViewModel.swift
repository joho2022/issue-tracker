//
//  IssueViewModel.swift
//  issue-tracker-01
//
//  Created by 조호근 on 5/20/24.
//

import Foundation

class IssueViewModel: BaseViewModel<Issue> {
    func deleteIssue(at index: Int, completion: @escaping (Bool) -> Void) {
        guard let issue = item(at: index) else {
            completion(false)
            return
        }
        
        NetworkManager.shared.deleteIssue(issueId: issue.id) { [weak self] success in
            
            if success {
                self?.removeItem(at: index)
                completion(true)
            } else {
                completion(false)
            }
        }
    }
    
    func closeIssue(at index: Int, completion: @escaping (Bool) -> Void) {
        guard let issue = item(at: index) else {
            completion(false)
            return
        }
        
        NetworkManager.shared.closeIssue(issueId: issue.id) { [weak self] success in
            
            if success {
                self?.removeItem(at: index)
                completion(true)
            } else {
                completion(false)
            }
        }
    }
}
