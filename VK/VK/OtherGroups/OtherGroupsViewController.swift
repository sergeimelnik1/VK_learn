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
    

    private var groups: [Group] = []

    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    private var isFiltering: Bool {
        let searchBarScopeIsFiltering = searchController.searchBar.selectedScopeButtonIndex != 0
        return searchController.isActive && (!searchBarIsEmpty || searchBarScopeIsFiltering)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        self.tableView.dataSource = self
//        https://debash.medium.com/uisearchcontroller-48dbc0f4cb63
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Поиск по группам..."
        searchController.searchBar.setValue("Отмена", forKey: "cancelButtonText")
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
        definesPresentationContext = true
    
        tableView.reloadData()
    }
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups.count
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        // получаем ячейку из пула
        let cell = tableView.dequeueReusableCell(withIdentifier: "otherGroupCell", for: indexPath) as! OtherGroupsCell
        var group: Group
        
        group = groups[indexPath.row]
        cell.setup(group: group)
        return cell
    }
    // MARK: - Navigation
//    //это если нам надо прыгать на другой экран и передавать туда данные для отображения детальной информации выбранной группы
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "showDetail" {
//            if let indexPath = tableView.indexPathForSelectedRow {
//                let group: Group
//                if isFiltering {
//                    group = filteredGroups[indexPath.row]
//                } else {
//                    group = groups[indexPath.row]
//                }
////                let detailVC = segue.destination as! DetailViewController
////                detailVC.group = group
//            }
//        }
//    }
    
}
// MARK: - UISearchResultsUpdating Delegate
extension OtherGroupsViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    private func filterContentForSearchText(_ searchText: String) {
        if searchText != "" {
            AuthService.loadSearchGroupList(query: searchText, success: { [weak self] groups in
                self?.groups = groups
                self?.tableView.reloadData()
            })
        } else {
            self.groups = []
            self.tableView.reloadData()
        }
        
    }
}
extension OtherGroupsViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
            filterContentForSearchText(searchBar.text!)
        }
}
