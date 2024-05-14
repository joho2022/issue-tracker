//
//  IssueViewModel.swift
//  issue-tracker-01
//
//  Created by 조호근 on 5/9/24.
//

import Foundation

class IssueViewModel {
    private(set) var issues: [Issue] = []

    var count: Int {
        return issues.count
    }
    
    func updateIssues(with newIssues: [Issue]) {
        self.issues = newIssues
    }
    
    func issue(at index: Int) -> Issue? {
        guard index >= 0 && index < issues.count else { return nil }
        return issues[index]
    }
    
    func removeIssue(at index: Int) {
        if index >= 0 && index < issues.count {
            issues.remove(at: index)
        }
    }
}
