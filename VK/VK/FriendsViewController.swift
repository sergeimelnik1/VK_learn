//
//  FriendsViewController.swift
//  VK
//
//  Created by Sergey Melnik on 12.04.2022.
//

import UIKit
import RealmSwift

#warning("UITableViewDataSource не вынесены в расширение, беспорядок в коде")
class FriendsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    private var friends: Results<Friend>?
    var token: NotificationToken?
    
    let myRefreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: .valueChanged)
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        self.tableView.dataSource = self
        self.navigationItem.setHidesBackButton(true, animated: true)
        self.tableView.refreshControl = myRefreshControl
        
        self.loadData()
    }
}
// MARK: - Table view data source

extension FriendsViewController: UITableViewDataSource {
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
extension FriendsViewController {
    
    @objc func refresh(sender: UIRefreshControl){
        self.loadData()
        sender.endRefreshing()
    }
    
    //передача информации при нажатии на конкретного друга
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toCurrentFriendViewController", let cell = sender as? UITableViewCell {
            let ctrl = segue.destination as! CurrentFriendViewController
            if let indexPath = tableView.indexPath(for: cell) {
                tableView.deselectRow(at: indexPath, animated: true)
                ctrl.friend = friends?[indexPath.row]
            }
        }
    }
    func loadData() {
        //увеличиваем версию базы на 1, чтобы новодобавленные поля не ломали app'ку
        var config = Realm.Configuration(
            schemaVersion: 1,
            migrationBlock: { migration, oldSchemaVersion in
                if (oldSchemaVersion < 1) {}
            })
        config.deleteRealmIfMigrationNeeded = true
        Realm.Configuration.defaultConfiguration = config
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
    //принудительное скрытие кнопки back
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.navigationItem.hidesBackButton = true
    }
}
