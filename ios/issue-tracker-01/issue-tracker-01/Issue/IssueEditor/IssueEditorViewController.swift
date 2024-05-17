//
//  IssueEditorViewController.swift
//  issue-tracker-01
//
//  Created by 조호근 on 5/16/24.
//

import UIKit

class IssueEditorViewController: UIViewController {

    static let identifier: String = "IssueEditorViewController"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.largeTitleDisplayMode = .never
        
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
        
        let segmentedControl = UISegmentedControl(items: ["마크다운", "미리보기"])
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(segmentChanged(_:)), for: .valueChanged)
        segmentedControl.frame = CGRect(origin: .zero, size: CGSize(width: 196.0, height: 32.0))
        
        let font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        segmentedControl.setTitleTextAttributes([.font: font, .foregroundColor: UIColor.gray], for: .normal)
        segmentedControl.setTitleTextAttributes([.font: font, .foregroundColor: UIColor.black], for: .selected)
        
        navigationItem.titleView = segmentedControl
    }
    
    @objc private func backBtnTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func saveBtnTapped() {
        print("저장")
    }
    
    @objc private func segmentChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            print("마크다운 선택됨")
        case 1:
            print("미리보기 선택됨")
        default:
            break
        }
    }
}
