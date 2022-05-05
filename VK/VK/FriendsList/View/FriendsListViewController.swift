//
//  FriendsViewController.swift
//  VK
//
//  Created by Sergey Melnik on 12.04.2022.
//

import UIKit
import RealmSwift

class FriendListViewController: UIViewController {
    
    var output : FriendListViewOutput?
    
    @IBOutlet weak var tableView: UITableView!
    
    private var friends: Results<Friend>?
    
    private let myRefreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: .valueChanged)
        return refreshControl
    }()
    
    //увеличиваем версию базы на 1, чтобы новодобавленные поля не ломали app'ку
    private var config = Realm.Configuration(
        schemaVersion: 1,
        migrationBlock: { migration, oldSchemaVersion in
            if (oldSchemaVersion < 1) {}
        })
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        overrideUserInterfaceStyle = .light
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.navigationItem.setHidesBackButton(true, animated: true)
        self.tableView.refreshControl = myRefreshControl
        //все что внизу выносим в interactor
        config.deleteRealmIfMigrationNeeded = true
        Realm.Configuration.defaultConfiguration = config
        //но тут нет передачи данных во friends
        //как лучше сделать, отдельным методом или вызовом данных из Realm'а
        self.output?.loadData()
    }
    
    //принудительное скрытие кнопки back
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tabBarController?.navigationItem.hidesBackButton = true
    }
}
// MARK: - Table view data source

extension FriendListViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // получаем ячейку из пула
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendCell", for: indexPath) as! FriendCell
        if indexPath.row == (friends?.count ?? 1) - 1 {
            cell.hideSeparator()
        }
        // получаем имя друга для конкретной строки
        if let friend = friends?[indexPath.row] {
        // устанавливаем имя друга в надпись ячейки
        cell.setup(friend: friend)
        }
        return cell
    }
    
    func tableView( _ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let friend = self.friends?[indexPath.row] {
            output?.enterFriendCell(friend: friend)
        }
    }
}
extension FriendListViewController {
    
    @objc func refresh(sender: UIRefreshControl){
        self.output?.loadData()
        self.tableView.reloadData()
        sender.endRefreshing()
    }
    


}
extension FriendListViewController: FriendListViewInput {
    func loadFriendData(friend: Results<Friend>) {
        self.friends = friend
        self.tableView.reloadData()
    }
    
    func getVC() -> UIViewController {
        return self
    }
}
