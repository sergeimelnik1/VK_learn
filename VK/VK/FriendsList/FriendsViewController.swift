//
//  FriendsViewController.swift
//  VK
//
//  Created by Sergey Melnik on 12.04.2022.
//

import UIKit

class FriendsViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var friends: [Friend] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        self.tableView.dataSource = self
        AuthService.loadFriendList(success: { [weak self] friends in
            self?.friends = friends
            self?.tableView.reloadData()
        })
    }
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // получаем ячейку из пула
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendCell", for: indexPath) as! FriendCell
        // получаем имя друга для конкретной строки
        let friend = friends[indexPath.row]
        // устанавливаем имя друга в надпись ячейки
        cell.setup(friend: friend)
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toCurrentFriendViewController", let cell = sender as? UITableViewCell {
            let ctrl = segue.destination as! CurrentFriendViewController
            if let indexPath = tableView.indexPath(for: cell) {
                ctrl.friend = friends[indexPath.row]
            }
        }
    }
}
