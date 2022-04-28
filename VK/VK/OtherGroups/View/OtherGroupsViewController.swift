//
//  OtherGroupsViewController.swift
//  VK
//
//  Created by Sergey Melnik on 12.04.2022.
//

import UIKit

class OtherGroupsViewController: UIViewController {
    
    var output : OtherGroupsViewOutput?
    
    @IBOutlet var tableView: UITableView!
    
    lazy var searchUIBar:UISearchBar = UISearchBar()
    private var currentSearchText = ""
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
        self.tableView.delegate = self
        //        https://debash.medium.com/uisearchcontroller-48dbc0f4cb63
        setupSearchController()
        tableView.reloadData()
    }
    
    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Сюда иди, текст введи быстро"
        searchController.searchBar.setValue("Ай, передумал", forKey: "cancelButtonText")
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
    }
}
// MARK: - UISearchResultsUpdating Delegate
extension OtherGroupsViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        self.filterContentForSearchText(searchController.searchBar.text!)
    }
    
    private func filterContentForSearchText(_ searchText: String) {
        if searchText != "" {
            GroupService.loadSearchGroupList(query: searchText, success: { [weak self] groups in
                self?.groups = groups
                self?.currentSearchText = searchText
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
        self.filterContentForSearchText(searchBar.text!)
        self.currentSearchText = searchBar.text!
    }
}
extension UIViewController {
    func activityIndicator(style: UIActivityIndicatorView.Style = .medium, frame: CGRect? = nil, center: CGPoint? = nil) -> UIActivityIndicatorView {
        
        // 2
        let activityIndicatorView = UIActivityIndicatorView(style: style)
        // 3
        if let frame = frame {
            activityIndicatorView.frame = frame
        }
        // 4
        if let center = center {
            activityIndicatorView.center = center
        }
        // 5
        return activityIndicatorView
    }
}
extension OtherGroupsViewController: UITableViewDataSource, UITableViewDelegate {
    
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
        if indexPath.row == (groups.count) - 1 {
            cell.hideSeparator()
        }
        cell.setup(group: group)
        return cell
    }
    //при нажатии выделение Cell пропадает
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        var actionTableView = UIContextualAction()
        if self.groups[indexPath.row].is_member.description == "0" {
            let action = UIContextualAction(style: .normal, title: "Add") { [weak self] (action, view, completionHandler) in
                //тут логика подписки на группу
                GroupService.followGroup(groupId: self?.groups[indexPath.row].id ?? 1, success: { [weak self] in
                    self?.filterContentForSearchText(self?.currentSearchText ?? "")
                    tableView.reloadData()
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "LoadGroups"), object: nil)
                })
                completionHandler(true)
            }
            actionTableView = action
            action.backgroundColor = .systemBlue
        } else if self.groups[indexPath.row].is_member.description == "1" {
            let action = UIContextualAction(style: .normal, title: "Leave") { [weak self] (action, view, completionHandler) in
                //тут логика подписки на группу
                GroupService.leaveGroup(groupId: self?.groups[indexPath.row].id ?? 1, success: { [weak self] in
                    self?.filterContentForSearchText(self?.currentSearchText ?? "")
                    tableView.reloadData()
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "LoadGroups"), object: nil)
                })
                //тут нотификация должна отрабатывать о добавлении элемента
                completionHandler(true)
            }
            actionTableView = action
            action.backgroundColor = .systemRed
        }
        return UISwipeActionsConfiguration(actions: [actionTableView])
    }
}
extension OtherGroupsViewController: OtherGroupsViewInput {
    func getVC() -> UIViewController {
        return self
    }
}
