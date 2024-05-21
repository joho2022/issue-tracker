//
//  LabelViewModel.swift
//  issue-tracker-01
//
//  Created by 조호근 on 5/20/24.
//

import Foundation

class LabelViewModel: BaseViewModel<Label> {
    static let shared = LabelViewModel()
    
    enum Notifications {
        static let labelCreated = Notification.Name("labelCreated")
    }
    
    func fetchLabels(completion: @escaping () -> Void) {
        NetworkManager.shared.fetchLabels { [weak self] labels in
            DispatchQueue.main.async {
                self?.updateItems(with: labels ?? [])
                completion()
            }
        }
    }
    
    func createLabel(labelRequest: LabelRequest, completion: @escaping (Bool) -> Void) {
        NetworkManager.shared.createLabel(label: labelRequest) { [weak self] success, createdLabel in
            DispatchQueue.main.async {
                if success, let newLabel = createdLabel {
                    self?.appendItem(newLabel)
                    NotificationCenter.default.post(name: Self.Notifications.labelCreated,
                                                    object: self
                    )
                    completion(true)
                } else {
                    completion(false)
                }
            }
        }
    }
}
