//
//  IssueListController.swift
//  issue-tracker-01
//
//  Created by 조호근 on 5/9/24.
//

import UIKit

class IssueListController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var issueViewModel = IssueViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "이슈"
        setupTableView()
        
        issueViewModel.fetchIssues {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    private func setupTableView() {
        tableView.register(UINib(nibName: "IssueTableCell", bundle: .main), forCellReuseIdentifier: IssueTableCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 148
    }
}

extension IssueListController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return issueViewModel.issues?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: IssueTableCell.identifier, for: indexPath) as? IssueTableCell else {
            return UITableViewCell()
        }
        
        if let issue = issueViewModel.issues?[indexPath.row] {
            cell.setIssue(issue)
        }
        
        return cell
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = createSwipeAction(title: "삭제",
                                             color: .myRed,
                                             image: UIImage(systemName: "trash.fill"),
                                             style: .destructive) { _, _, completionHandler in
            print("삭제")
            completionHandler(true)
        }

        let closeAction = createSwipeAction(title: "닫기",
                                             color: .myPurple,
                                             image: UIImage(systemName: "archivebox.fill"),
                                             style: .destructive) { _, _, completionHandler in
            print("닫기")
            completionHandler(true)
        }
        
        let config = UISwipeActionsConfiguration(actions: [deleteAction, closeAction])
        config.performsFirstActionWithFullSwipe = false
        return config
    }
}
