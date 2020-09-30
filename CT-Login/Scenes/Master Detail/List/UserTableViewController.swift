//
//  UserTableViewController.swift
//  CT-Login
//
//  Created by Mac Mini 2 on 9/30/20.
//

import UIKit
import Combine

class UserTableViewController: UITableViewController {

    private lazy var viewModel : UserTableViewModel = {
        return UserTableViewModel()
    }()
    private var subscriptions = Set<AnyCancellable>()

    class func instantiate() -> UITableViewController {
        let viewController = UserTableViewController.instantiate(fromStoryboard: .Details)
        return viewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
        configureBindings()
    }
    
    private func configureView() {
        tableView.register(nib: [ItemTableViewCell.self])
        let control = UIRefreshControl()
        control.addTarget(self, action: #selector(loadList), for: .valueChanged)
        self.refreshControl = control
    }
    
    private func configureBindings() {
        viewModel.$dataSource.sink { (users) in
            self.tableView.reloadData()
            self.refreshControl?.endRefreshing()
        }.store(in: &subscriptions)
        
        viewModel.$errorModel.sink { (errorModel) in
            guard let error = errorModel else { return }
            self.showNetworkError(error)
            self.refreshControl?.endRefreshing()
        }.store(in: &subscriptions)
    }
    
    @objc private func loadList() {
        viewModel.fetchUsers()
    }
}

// MARK: UITableViewDataSourceDelegate
extension UserTableViewController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : ItemTableViewCell = tableView.dequeueReusableCell()
        cell.configure(viewModel.getItemModel(indexPath.row))
        return cell 
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.dataSource.count
    }
}
