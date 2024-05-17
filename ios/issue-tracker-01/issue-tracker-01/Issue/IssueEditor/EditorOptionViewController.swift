//
//  EditorOptionViewController.swift
//  issue-tracker-01
//
//  Created by 조호근 on 5/17/24.
//

import UIKit

class EditorOptionViewController: UIViewController {

    static let identifier: String = "EditorOptionViewController"
    
    @IBOutlet weak var tableView: UITableView!
    
    var sectionTitle: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavigationBar()
    }
    
    private func configureNavigationBar() {
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"),
                                         style: .plain,
                                         target: self,
                                         action: #selector(backBtnTapped)
        )
        navigationItem.leftBarButtonItem = backButton
        
        let saveButton = UIBarButtonItem(title: "저장",
                                         style: .plain,
                                         target: self,
                                         action: #selector(saveBtnTapped)
        )
        navigationItem.rightBarButtonItem = saveButton
        
        if let title = sectionTitle {
            navigationItem.title = title
        }
    }
    
    @objc private func backBtnTapped() {
        navigationController?.dismiss(animated: true)
    }
    
    @objc private func saveBtnTapped() {
        
    }
}
