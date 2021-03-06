//
//  OtherGroupsViewController.swift
//  VK
//
//  Created by Sergey Melnik on 12.04.2022.
//

import UIKit

class OtherGroupsViewController: UIViewController {

    var output: OtherGroupsViewOutput?
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var bar: Bar!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.bar.output = self//нужно для работы xib
        self.bar.setup(backButtonText: "Назад", title: "Поиск по группам")
        overrideUserInterfaceStyle = .light
        self.tableView.dataSource = self
        self.tableView.delegate = self

        self.activityIndicator.isHidden = true
        //        https://debash.medium.com/uisearchcontroller-48dbc0f4cb63
        self.tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
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
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(self.loadAfterDelay(_:)), object: searchBar)
        self.perform(#selector(self.loadAfterDelay(_:)), with: searchBar, afterDelay: 1)
    }
    
    @objc func loadAfterDelay(_ searchBar: UISearchBar) {
        if searchBar.text != "" {
            self.onActivityIndicator()
            guard let searchText = searchBar.text else { return }
            self.output?.filterContentForSearchText(searchText)
        } else {
            self.output?.clearGroup()
        }
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        
        if let group: GroupModel = self.output?.getIndexPathRowGroup(indexPath.row) {
            if indexPath.row == (self.output?.getCountGroups() ?? 1) - 1 {
                cell.hideSeparator()
            }
            cell.setup(name: group.name, image: group.image50)
        }
        return cell
    }

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
    
    func onActivityIndicator() {
        self.activityIndicator.isHidden = false
        self.activityIndicator.startAnimating()
    }
    
    func offActivityIndicator() {
        self.activityIndicator.isHidden = true
        self.activityIndicator.stopAnimating()
    }
    
    func getVC() -> UIViewController {
        return self
    }
    func reload() {
        self.tableView.reloadData()
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

extension OtherGroupsViewController: BarOutput {
    func dismiss() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func openOtherGroups() {
        
    }
}
