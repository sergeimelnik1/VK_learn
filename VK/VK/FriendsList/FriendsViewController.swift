//
//  FriendsViewController.swift
//  VK
//
//  Created by Sergey Melnik on 12.04.2022.
//

import UIKit
import RealmSwift

class FriendsViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var friends: Results<Friend>?

//    var friends: [Friend] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        self.tableView.dataSource = self
        self.navigationItem.setHidesBackButton(true, animated: true)
        loadData()
    }
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // получаем ячейку из пула
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendCell", for: indexPath) as! FriendCell
        // получаем имя друга для конкретной строки
        let friend = friends?[indexPath.row]
        // устанавливаем имя друга в надпись ячейки
        cell.setup(friend: friend!)
        return cell
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
        do {
            let realm = try Realm()
            AuthService.loadFriendList()
            let friends = realm.objects(Friend.self)
            
            self.friends = friends
            self.tableView.reloadData()
        } catch {
            // если произошла ошибка, выводим ее в консоль
            print(error)
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.navigationItem.hidesBackButton = true
    }
    
}
