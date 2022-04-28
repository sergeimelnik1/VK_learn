//
//  FriendsViewController.swift
//  VK
//
//  Created by Sergey Melnik on 12.04.2022.
//

import UIKit
import RealmSwift

class FriendsListViewController: UIViewController {
    
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
        config.deleteRealmIfMigrationNeeded = true
        Realm.Configuration.defaultConfiguration = config
        
        self.loadData()
    }
    
    //принудительное скрытие кнопки back
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tabBarController?.navigationItem.hidesBackButton = true
    }
}
// MARK: - Table view data source

extension FriendsListViewController: UITableViewDataSource, UITableViewDelegate {
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
        let friend = friends?[indexPath.row]
        
        // устанавливаем имя друга в надпись ячейки
        cell.setup(friend: friend!)
        return cell
    }
}
extension FriendsListViewController {
    
    @objc func refresh(sender: UIRefreshControl){
        self.loadData()
        sender.endRefreshing()
    }
    
    func tableView( _ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard: UIStoryboard = UIStoryboard(name: "CurrentFriendViewController", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "CurrentFriendViewController") as! CurrentFriendViewController
        vc.friend = self.friends?[indexPath.row]
        vc.modalPresentationStyle = .fullScreen
        tableView.deselectRow(at: indexPath, animated: true)
        self.present(vc, animated: false, completion: nil)
    }
    
    private func loadData() {
        do {
            let realm = try Realm()
            print(realm.configuration.fileURL!)
            FriendService.loadFriendList()
            let friends = realm.objects(Friend.self)
            self.friends = friends
            self.tableView.reloadData()
        } catch {
            // если произошла ошибка, выводим ее в консоль
            print(error)
        }
    }
}
