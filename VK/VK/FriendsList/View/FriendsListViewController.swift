//
//  FriendsViewController.swift
//  VK
//
//  Created by Sergey Melnik on 12.04.2022.
//

import UIKit
import RealmSwift

class FriendsListViewController: UIViewController {
     
    var output : FriendListViewOutput?
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var bar: Bar!
    @IBOutlet weak var tableView: UITableView!
    
    private let myRefreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: .valueChanged)
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.bar.output = self
        self.bar.setup("", "", "Мои друзья")
        overrideUserInterfaceStyle = .light
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.navigationItem.setHidesBackButton(true, animated: true)
        self.tableView.refreshControl = myRefreshControl
        self.activityIndicator.isHidden = true

        self.output?.viewIsReady()
    }
}
// MARK: - Table view data source

extension FriendsListViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.output?.getCountFriends() ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // получаем ячейку из пула
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendCell", for: indexPath) as! FriendCell
        if indexPath.row == (self.output?.getCountFriends() ?? 1) - 1 {
            cell.hideSeparator()
        }
        // получаем имя друга для конкретной строки
        if let friend = self.output?.getIndexPathRowFriend(indexPath.row) {
            // устанавливаем имя друга в надпись ячейки
            cell.setup(friend: friend)
        }
        return cell
    }
    
    func tableView( _ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let friend = self.output?.getIndexPathRowFriend(indexPath.row) {
            self.output?.enterFriendCell(friend: friend)
        }
    }
}
extension FriendsListViewController {
    
    @objc func refresh(sender: UIRefreshControl){
        self.output?.loadData()
        sender.endRefreshing()
    }
    
}
extension FriendsListViewController: FriendListViewInput {
    
    func getVC() -> UIViewController {
        return self
    }
    
    func reload() {
        self.tableView.reloadData()
    }
    
    func onActivityIndicator() {
        self.activityIndicator.isHidden = false
        self.activityIndicator.startAnimating()
    }
    
    func offActivityIndicator() {
        self.activityIndicator.isHidden = true
        self.activityIndicator.stopAnimating()
    }
}
extension FriendsListViewController: BarOutput {
    func dismiss() {
        
    }
    
    func openOtherGroups() {
        
    }
}
