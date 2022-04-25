//
//  AllGroupsViewController.swift
//  VK
//
//  Created by Sergey Melnik on 12.04.2022.
//

import UIKit
import RealmSwift
import SwiftUI

#warning("UITableViewDataSource не вынесены в расширение, беспорядок в коде")
class AllGroupsViewController: UIViewController {
    
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
        
        var config = Realm.Configuration(
            schemaVersion: 1,
            migrationBlock: { migration, oldSchemaVersion in
                if (oldSchemaVersion < 1) {}
            })
        config.deleteRealmIfMigrationNeeded = true
        Realm.Configuration.defaultConfiguration = config
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.refreshControl = myRefreshControl
        NotificationCenter.default.addObserver(self, selector: #selector(loadGroupsAfterEdit(notification:)), name: NSNotification.Name(rawValue: "LoadGroups"), object: nil)
        self.loadData()
    }
    //перезагрузка контроллера руками
    @objc func refresh(sender: UIRefreshControl){
        self.loadData()
        sender.endRefreshing()
    }
    
    //метод дергается после нотификации о удалении или добавлении группы
    @objc func loadGroupsAfterEdit(notification: Notification) {
        GroupService.loadGroupList(success: { [weak self] in
            self?.tableView.reloadData()
        })
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
            GroupService.loadGroupList(success: { [weak self] in
                let groups = realm.objects(Group.self)
                self?.groups = groups
                self?.tableView.reloadData()
            })
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
// MARK: - Table view data source

extension AllGroupsViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // получаем ячейку из пула
        let cell = tableView.dequeueReusableCell(withIdentifier: "groupCell", for: indexPath) as! AllGroupsCell
        if indexPath.row == (groups?.count ?? 1) - 1 {
            cell.hideSeparator()
        }
        // получаем название группы для конкретной строки
        if let group = groups?[indexPath.row] {
            cell.setup(group: group)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .normal, title: "Leave") { [weak self] (action, view, completionHandler) in
                //тут логика отписки от группы
            GroupService.leaveGroup(groupId: self?.groups?[indexPath.row].id ?? 1, success: { [weak self] in
                self?.loadData()
            })
//                GroupService.leaveGroup(groupId: self?.groups?[indexPath.row].id ?? 1)
                
                //тут нотификация должна отрабатывать о добавлении элемента
                completionHandler(true)
        }
        action.backgroundColor = .systemRed
        return UISwipeActionsConfiguration(actions: [action])
    }
}
