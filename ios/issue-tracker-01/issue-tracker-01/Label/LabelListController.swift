//
//  LabelListController.swift
//  issue-tracker-01
//
//  Created by 조호근 on 5/9/24.
//

import UIKit

class LabelListController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let labelViewModel = BaseViewModel<Label>()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "레이블"
        
        configureNavigationBar()
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.register(UINib(nibName: LabelTableCell.identifier, bundle: .main), forCellReuseIdentifier: LabelTableCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
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
        
        return cell
    }
}
