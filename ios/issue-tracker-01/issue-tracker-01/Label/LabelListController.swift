//
//  LabelListController.swift
//  issue-tracker-01
//
//  Created by 조호근 on 5/9/24.
//

import UIKit

class LabelListController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var labelViewModel: LabelViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        labelViewModel = LabelViewModel.shared
        
        self.title = "레이블"
        
        configureNavigationBar()
        setupTableView()
        fetchLabels()
        registerForNotifications()
    }
    
    private func registerForNotifications() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(handleLabelCreated),
                                               name: LabelViewModel.Notifications.labelCreated,
                                               object: nil
        )
    }
    
    @objc private func handleLabelCreated(notification: Notification) {
        self.tableView.reloadData()
    }
    
    private func setupTableView() {
        tableView.register(UINib(nibName: LabelTableCell.identifier, bundle: .main), forCellReuseIdentifier: LabelTableCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 84
    }
    
    private func fetchLabels() {
        self.labelViewModel.fetchLabels {
            self.tableView.reloadData()
        }
    }
    
    private func configureNavigationBar() {
        let addButton = UIBarButtonItem(title: "추가",
                                        style: .plain,
                                        target: self,
                                        action: #selector(addBtnTapped)
        )
        navigationItem.rightBarButtonItem = addButton
    }
    
    @objc private func addBtnTapped() {
        let labelEditorVC = LabelEditorViewController(nibName: LabelEditorViewController.identifier, bundle: nil)
        
        let navigationController = UINavigationController(rootViewController: labelEditorVC)
        present(navigationController, animated: true)
    }
}

extension LabelListController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return labelViewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LabelTableCell.identifier, for: indexPath) as? LabelTableCell else {
            return UITableViewCell()
        }
        
        if let label = labelViewModel.item(at: indexPath.row) {
            cell.setLabel(label)
        }
        
        return cell
    }
}
