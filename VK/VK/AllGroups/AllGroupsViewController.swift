//
//  AllGroupsViewController.swift
//  VK
//
//  Created by Sergey Melnik on 12.04.2022.
//

import UIKit
import RealmSwift

class AllGroupsViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    private var groups: Results<Group>?
    let myRefreshControl: UIRefreshControl = {
    let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: .valueChanged)
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        self.tableView.dataSource = self
        self.tableView.refreshControl = myRefreshControl
        loadData()
    }
    
    @objc func refresh(sender: UIRefreshControl){
        loadData()
        self.tableView.reloadData()
        sender.endRefreshing()
    }
    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups?.count ?? 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // получаем ячейку из пула
        let cell = tableView.dequeueReusableCell(withIdentifier: "groupCell", for: indexPath) as! AllGroupsCell
        // получаем название группы для конкретной строки
        let group = groups?[indexPath.row]
        cell.setup(group: group!)
        return cell
    }
    
    //обработка нажатия на конкретную группу
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toOtherGroups", let cell = sender as? UITableViewCell {
            _ = segue.destination as! OtherGroupsViewController
            if let indexPath = tableView.indexPath(for: cell) {
                tableView.deselectRow(at: indexPath, animated: true)
            }
        }
    }

    func loadData() {
            do {
                let realm = try Realm()
                AuthService.loadGroupList()
                let groups = realm.objects(Group.self)
                self.groups = groups
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
