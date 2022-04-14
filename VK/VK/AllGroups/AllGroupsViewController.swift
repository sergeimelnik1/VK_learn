//
//  AllGroupsViewController.swift
//  VK
//
//  Created by Sergey Melnik on 12.04.2022.
//

import UIKit

class AllGroupsViewController: UIViewController, UITableViewDataSource {

    @IBOutlet var tableView: UITableView!
    @IBAction func addButtonPressed(_ sender: Any) {
        showAddGroupForm()
    }
    var groups = [
    "Точка кипения ТвГУ",
    "Студенческий совет ТвГУ",
    "Арт-буфет Кафедра"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        self.tableView.dataSource = self
        //тут не добавляется кнопка
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(showAddGroupForm))
        //navigationItem.rightBarButtonItem = addButton
       // navigationController?.navigationItem.rightBarButtonItem = addButton
        let rightButton = UIBarButtonItem.init(title: "Title", style: .plain, target: self, action: #selector(showAddGroupForm))
        navigationItem.rightBarButtonItem = rightButton

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
//         self.navigationItem.rightBarButtonItem = self.editButtonItem
//        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "groupCell")
        tableView.reloadData()
    }
    
    func addGroup(newGroupName: String) {
        if let indexPath = self.tableView.indexPathForSelectedRow {
            // получаем город по индексу
            let group = self.groups[indexPath.row]
            //проверяем есть ли такой элемент в массиве
            if !groups.contains(group){
                //добавляем
                groups.append(newGroupName)
                //перезагружаем всю таблицу
                tableView.reloadData()
            }
        }
    }
    @objc func showAddGroupForm() {
        let alertController = UIAlertController(title: "Введите группу", message: nil, preferredStyle: .alert)
        alertController.addTextField(configurationHandler: {(_ textField: UITextField) -> Void in
        })
        let confirmAction = UIAlertAction(title: "Добавить", style: .default) { [weak self] action in
            guard let name = alertController.textFields?[0].text else { return }
            self?.addGroup(newGroupName: name)
        }
        alertController.addAction(confirmAction)
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: {  })
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
            
            // устанавливаем название группы в надпись ячейки
            cell.groupName.text = group
            cell.groupImage.image = UIImage(named: "VK_Compact_Logo")

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
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            // если была нажата кнопка удалить
            if editingStyle == .delete {
            // мы удаляем город из массива
                groups.remove(at: indexPath.row)
            // и удаляем строку из таблицы
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }


    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
