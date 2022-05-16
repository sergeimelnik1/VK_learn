//
//  OtherGroupsViewController.swift
//  VK
//
//  Created by Sergey Melnik on 12.04.2022.
//

import UIKit

class OtherGroupsViewController: UIViewController {
    
    var output: OtherGroupsViewOutput?
    
    @IBOutlet var tableView: UITableView!
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    private var searchBarIsEmpty: Bool {
        guard let text = searchBar.text else { return false }
        return text.isEmpty
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        self.tableView.dataSource = self
        self.tableView.delegate = self
        //        https://debash.medium.com/uisearchcontroller-48dbc0f4cb63
        setupSearchBar()
    }
    
    private func setupSearchBar() {
        searchBar.delegate = self
        searchBar.placeholder = "Поиск по группам"
    }
}
// MARK: - UISearchResultsUpdating Delegate
extension OtherGroupsViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        self.output?.filterContentForSearchText(searchController.searchBar.text!)
    }
}

extension OtherGroupsViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.output?.filterContentForSearchText(searchBar.text!)
        self.output?.edidCurrentSearchText(searchBar.text!)
        self.tableView.reloadData()
    }
}

extension OtherGroupsViewController: UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.output?.getCountGroups() ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // получаем ячейку из пула
        let cell = tableView.dequeueReusableCell(withIdentifier: "otherGroupCell", for: indexPath) as! OtherGroupsCell
        //        var group: Group
        
        if let group: Group = self.output?.getIndexPathRowGroup(indexPath.row) {
            if indexPath.row == (self.output?.getCountGroups() ?? 1) - 1 {
                cell.hideSeparator()
            }
            cell.setup(group: group)
        }
        return cell
        
    }
    //при нажатии выделение Cell пропадает
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        var actionTableView = UIContextualAction()
        if self.output?.getIndexPathRowGroup(indexPath.row)?.is_member.description == "0" {
            let action = UIContextualAction(style: .normal, title: "Add") { [weak self] (action, view, completionHandler) in
                self?.output?.followGroup(self?.output?.getIndexPathRowGroup(indexPath.row)?.id ?? 1, self?.output?.getCurrentSearchText() ?? "")
                self?.tableView.reloadData()
                completionHandler(true)
            }
            actionTableView = action
            action.backgroundColor = .systemBlue
        } else if self.output?.getIndexPathRowGroup(indexPath.row)?.is_member.description == "1" {
            let action = UIContextualAction(style: .normal, title: "Leave") { [weak self] (action, view, completionHandler) in
                self?.output?.leaveGroup(self?.output?.getIndexPathRowGroup(indexPath.row)?.id ?? 1, self?.output?.getCurrentSearchText() ?? "")
                self?.tableView.reloadData()
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
extension UIViewController {
    func activityIndicator(style: UIActivityIndicatorView.Style = .medium, frame: CGRect? = nil, center: CGPoint? = nil) -> UIActivityIndicatorView {
        
        let activityIndicatorView = UIActivityIndicatorView(style: style)
        if let frame = frame {
            activityIndicatorView.frame = frame
        }
        if let center = center {
            activityIndicatorView.center = center
        }
        return activityIndicatorView
    }
}
