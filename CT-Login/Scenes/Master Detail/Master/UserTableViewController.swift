//
//  UserTableViewController.swift
//  CT-Login
//
//  Created by Mac Mini 2 on 9/30/20.
//

import UIKit
import Combine

protocol UserSelectedDelegate : class {
    func updateUserDetailsViewController(_ detailsModel: DetailsModel)
}

class UserTableViewController: UITableViewController {

    private lazy var viewModel : UserTableViewModel = {
        return UserTableViewModel()
    }()
    private var subscriptions = Set<AnyCancellable>()
    private var delegate : UserSelectedDelegate?
    private var detailsViewController : DetailsViewController?
    
    func setDelegate(_ detailsViewController : DetailsViewController) {
        self.delegate = detailsViewController
        self.detailsViewController = detailsViewController
        self.configureBindings()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.refreshControl?.beginRefreshing()
        loadList()
    }
    
    private func configureView() {
        tableView.register(nib: [ItemTableViewCell.self])
        tableView.tableFooterView = UIView()
        let control = UIRefreshControl()
        control.addTarget(self, action: #selector(loadList), for: .valueChanged)
        self.refreshControl = control
    }
    
    private func configureBindings() {
        viewModel.$dataSource.sink { (users) in
            self.refreshControl?.endRefreshing()
            self.tableView.reloadData()
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

// MARK: UITableViewDataSource
extension UserTableViewController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : ItemTableViewCell = tableView.dequeueReusableCell()
        cell.configure(viewModel.getItemModel(indexPath.row))
        return cell 
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.dataSource
    }
}

// MARK: UITableViewDelegate
extension UserTableViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.updateUserDetailsViewController(viewModel.getDetailsViewModel(indexPath.row))
        tableView.deselectRow(at: indexPath, animated: true)
        if let splitViewController = self.navigationController?.splitViewController,
           let viewController = detailsViewController {
            splitViewController.showDetailViewController(viewController, sender: self)
        }
    }
}


