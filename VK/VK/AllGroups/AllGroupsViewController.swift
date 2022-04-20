//
//  AllGroupsViewController.swift
//  VK
//
//  Created by Sergey Melnik on 12.04.2022.
//

import UIKit

class AllGroupsViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    var groups: [Group] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        //        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        self.tableView.dataSource = self
        AuthService.loadGroupList(success: { [weak self] groups in
            self?.groups = groups
            self?.tableView.reloadData()
        })
//        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return groups.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // получаем ячейку из пула
        let cell = tableView.dequeueReusableCell(withIdentifier: "groupCell", for: indexPath) as! AllGroupsCell
        // получаем название группы для конкретной строки
        let group = groups[indexPath.row]
        cell.setup(group: group)
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
//     Override to support editing the table view.
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//            // если была нажата кнопка удалить
//            if editingStyle == .delete {
//            // мы удаляем город из массива
//                groups.remove(at: indexPath.row)
//            // и удаляем строку из таблицы
//                tableView.deleteRows(at: [indexPath], with: .fade)
//            }
//        }
}
