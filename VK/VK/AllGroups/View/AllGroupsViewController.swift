//
//  AllGroupsViewController.swift
//  VK
//
//  Created by Sergey Melnik on 12.04.2022.
//

import UIKit
import RealmSwift
import SwiftUI

final class AllGroupsViewController: UIViewController {
  
    var output : AllGroupsViewOutput?//нужно для работы xib
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var bar: Bar!//нужно для работы xib
    @IBOutlet var table: UITableView!
    
    private let myRefreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: .valueChanged)
        return refreshControl
    }()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.bar.output = self//нужно для работы xib
        bar.setup("", "plus_icon", "Все группы")
        overrideUserInterfaceStyle = .light
        self.table.dataSource = self
        self.table.delegate = self
        self.table.refreshControl = myRefreshControl
        self.table.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")

        self.output?.viewIsReady()
    }
    
    //перезагрузка контроллера руками
    @objc func refresh(sender: UIRefreshControl) {
        self.output?.loadGroups()
        self.table.reloadData()
        sender.endRefreshing()
    }
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
        //         получаем ячейку из пула
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        if indexPath.row == (self.output?.getCountGroups() ?? 1) - 1 {
            cell.hideSeparator()
        }
        // получаем название группы для конкретной строки
        if let group = self.output?.getIndexPathRowGroup(indexPath.row) {
            cell.setup(name: group.name, image: group.image50)
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
                self?.output?.leaveGroup(group.id)
                completionHandler(true)
            }
            self?.table.reloadData()
            
        }
        action.backgroundColor = .systemRed
        return UISwipeActionsConfiguration(actions: [action])
    }
}

extension AllGroupsViewController: AllGroupsViewInput {
    
    func getVC() -> UIViewController {
        return self
    }
    
    func reload() {
        self.table.reloadData()
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
extension AllGroupsViewController: BarOutput {
    func dismiss() {
        
    }
    
    func openOtherGroups() {
        self.output?.openOtherGroups()
    }
}
