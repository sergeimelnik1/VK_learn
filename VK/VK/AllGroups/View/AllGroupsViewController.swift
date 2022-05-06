//
//  AllGroupsViewController.swift
//  VK
//
//  Created by Sergey Melnik on 12.04.2022.
//

import UIKit
import RealmSwift
import SwiftUI

class AllGroupsViewController: UIViewController {
    
    var output : AllGroupsViewOutput?
    @IBAction func otherGroupsButton(_ sender: Any) {
        self.output?.openOtherGroups()
    }
    @IBOutlet var table: UITableView!
//    private var groups: Results<Group>?
    
    private let myRefreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: .valueChanged)
        return refreshControl
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        overrideUserInterfaceStyle = .light
        //ниже в viewIsReady засунуть
        var config = Realm.Configuration(
            schemaVersion: 1,
            migrationBlock: { migration, oldSchemaVersion in
                if (oldSchemaVersion < 1) {}
            })
        config.deleteRealmIfMigrationNeeded = true
        Realm.Configuration.defaultConfiguration = config
        
        self.table.dataSource = self
        self.table.delegate = self
        self.table.refreshControl = myRefreshControl
        NotificationCenter.default.addObserver(self, selector: #selector(loadGroupsAfterEdit(notification:)), name: NSNotification.Name(rawValue: "LoadGroups"), object: nil)
        output?.viewIsReady()
        self.output?.loadGroups()
        self.table.reloadData()
    }
    
    //принудительное скрытие кнопки back
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tabBarController?.navigationItem.hidesBackButton = true
    }
    
    //перезагрузка контроллера руками
    @objc func refresh(sender: UIRefreshControl){
        self.output?.loadGroups()
        self.table.reloadData()
        sender.endRefreshing()
    }
    
    //метод дергается после нотификации о удалении или добавлении группы
    @objc func loadGroupsAfterEdit(notification: Notification) {
        GroupService.loadGroupList(success: { [weak self] in
            self?.table.reloadData()
        })
    }
    
//    //обработка нажатия на конкретную группу
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if let cell = sender as? UITableViewCell {
//            if let indexPath = table.indexPath(for: cell) {
//                table.deselectRow(at: indexPath, animated: true)
//            }
//        }
//        self.output?.openOtherGroups()
//
//    }
}
// MARK: - Table view data source

extension AllGroupsViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.output?.getCountGroups() ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // получаем ячейку из пула
        let cell = tableView.dequeueReusableCell(withIdentifier: "groupCell", for: indexPath) as! AllGroupsCell
        if indexPath.row == (self.output?.getCountGroups() ?? 1) - 1 {
            cell.hideSeparator()
        }
        // получаем название группы для конкретной строки
        if let group = self.output?.getIndexPathRowGroup(indexPath.row) {
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
            if let group = self?.output?.getIndexPathRowGroup(indexPath.row) {
                GroupService.leaveGroup(groupId: group.id, success: { [weak self] in
                    self?.output?.loadGroups()
                    self?.table.reloadData()
                })
                
                //тут нотификация должна отрабатывать о добавлении элемента
                completionHandler(true)
            }
        }
        action.backgroundColor = .systemRed
        return UISwipeActionsConfiguration(actions: [action])
    }
}
extension AllGroupsViewController: AllGroupsViewInput {
    func getVC() -> UIViewController {
        return self
    }
}
