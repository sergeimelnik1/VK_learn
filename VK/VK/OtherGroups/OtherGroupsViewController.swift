//
//  OtherGroupsViewController.swift
//  VK
//
//  Created by Sergey Melnik on 12.04.2022.
//

import UIKit

class OtherGroupsViewController: UIViewController, UITableViewDataSource {

    @IBOutlet var tableView: UITableView!
    lazy var searchUIBar:UISearchBar = UISearchBar()
    private let searchController = UISearchController(searchResultsController: nil)
    

    private let groups = [
        Group(name: "Балкан Гриль", type: .myGroup),
        Group(name: "Бочка", type: .myGroup),
        Group(name: "Вкусные истории", type: .myGroup),
        Group(name: "Дастархан", type: .myGroup),
        Group(name: "Индокитай", type: .allGroup),
        Group(name: "Классик", type: .allGroup),
        Group(name: "Шок", type: .allGroup),
        Group(name: "Bonsai", type: .myGroup),
        Group(name: "Burger Heroes", type: .allGroup),
        Group(name: "Kitchen", type: .allGroup),
        Group(name: "Love&Life", type: .myGroup),
        Group(name: "Morris Pub", type: .allGroup),
        Group(name: "Speak Easy", type: .allGroup),
        Group(name: "X.O", type: .myGroup)
    ]

    private var filteredGroups: [Group] = []
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    private var isFiltering: Bool {
        let searchBarScopeIsFiltering = searchController.searchBar.selectedScopeButtonIndex != 0
        return searchController.isActive && (!searchBarIsEmpty || searchBarScopeIsFiltering)
    }
    private func filterContentForSearchText(_ searchText: String, scope: String = "Все группы") {
        
        filteredGroups = groups.filter({ (group: Group) -> Bool in
            
            let doesCategoryMatch = (scope == "Все группы") || (group.type.rawValue == scope)
            
            if searchBarIsEmpty {
                return doesCategoryMatch
            } else {
                return doesCategoryMatch && group.name.lowercased().contains(searchText.lowercased())
            }
        })
        
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        self.tableView.dataSource = self
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Поиск по группам..."
        searchController.searchBar.setValue("Отмена", forKey: "cancelButtonText")
        // Setup the Scope Bar
        searchController.searchBar.scopeButtonTitles = ["Все группы", "Мои группы"]
        searchController.searchBar.delegate = self

        navigationItem.searchController = searchController
        definesPresentationContext = true
    
        tableView.reloadData()
    }
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filteredGroups.count
        }
        return groups.count
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        // получаем ячейку из пула
        let cell = tableView.dequeueReusableCell(withIdentifier: "otherGroupCell", for: indexPath) as! OtherGroupsCell
        // получаем название группы для конкретной строки
        var group: Group

        if isFiltering {
            group = filteredGroups[indexPath.row]
        } else {
            group = groups[indexPath.row]
        }
        // устанавливаем название группы в надпись ячейки
        cell.imageView?.image = UIImage(named: "VK_Compact_Logo")
        cell.groupName.text = group.name
        cell.followersCount.text = "10000"
        return cell
    }
    // MARK: - Navigation
    //это если нам надо прыгать на другой экран и передавать туда данные для отображения детальной информации выбранной группы
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let group: Group
                if isFiltering {
                    group = filteredGroups[indexPath.row]
                } else {
                    group = groups[indexPath.row]
                }
//                let detailVC = segue.destination as! DetailViewController
//                detailVC.group = group
            }
        }
    }
    
}
// MARK: - UISearchResultsUpdating Delegate
extension OtherGroupsViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        filterContentForSearchText(searchController.searchBar.text!, scope: scope)
    }
    
    private func filterContentForSearchText(_ searchText: String) {
        
        filteredGroups = groups.filter({ (groups: Group) -> Bool in
            return groups.name.lowercased().contains(searchText.lowercased())
        })
        
        tableView.reloadData()
    }
}
extension OtherGroupsViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
            filterContentForSearchText(searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope])
        }
}
