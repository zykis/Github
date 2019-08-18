//
//  ViewController.swift
//  Github
//
//  Created by Артём Зайцев on 15.08.2019.
//  Copyright © 2019 Артём Зайцев. All rights reserved.
//

import UIKit

let userCellIdentifier = "UserCell"
let userCellNibName = "UserCell"
let userCellHeight: CGFloat = 104.0

class UserViewController: UIViewController {
    var presenter: UserPresenter!
    @IBOutlet weak var tableView: UITableView?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.presenter = UserPresenter(view: self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.presenter = UserPresenter(view: self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
        self.presenter.handleViewDidLoad()
    }
    
    private func setupTableView() {
        self.tableView?.register(UINib(nibName: userCellNibName, bundle: nil), forCellReuseIdentifier: userCellIdentifier)
        self.tableView?.dataSource = self
        self.tableView?.delegate = self
    }
}


extension UserViewController: UserViewProtocol {
    func reloadData() {
        self.tableView?.reloadData()
    }
}


extension UserViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.presenter.userCount()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = self.tableView?.dequeueReusableCell(withIdentifier: userCellIdentifier) as? UserCell {
            let user = presenter.user(at: indexPath)
            cell.update(with: user)
            return cell
        }
        return UITableViewCell()
    }
}


extension UserViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return userCellHeight
    }
}
