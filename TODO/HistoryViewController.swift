//
//  HistoryViewController.swift
//  TODO
//
//  Created by Michał Jarosz on 01/08/2019.
//  Copyright © 2019 Michał Jarosz. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var toDoItems : [ToDoItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //navigation item
        navigationItem.title = "Completed"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Clear", style: .plain, target: self, action: #selector(clearHistory))
        
        tableView.dataSource = self
        tableView.delegate = self
        
        getToDoItems()
    }
    
    //COREDATA
    func getToDoItems() {
        //get to do items from coredata
        
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            
            do {
                //set to class property
                toDoItems = try context.fetch(ToDoItem.fetchRequest())
            } catch {}
        }
        
        for todoitem in toDoItems {
            if todoitem.completed == false {
                let index = toDoItems.firstIndex(of: todoitem)!
                toDoItems.remove(at: index)
            }
        }
        
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = toDoItems[indexPath.row].name
        cell.detailTextLabel?.text = "details"
        return cell
    }
    
    //SEGUE
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let defVC = segue.destination as! CompletedInfoViewController
        defVC.toDoItem = sender as! ToDoItem
        defVC.previousVC = self
    }
    
    //show details
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let sender = toDoItems[indexPath.row]
        performSegue(withIdentifier: "completedInfoSegue", sender: sender)
    }
    
    //clear history
    @objc func clearHistory() {
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            for todoitem in toDoItems {
                context.delete(todoitem)
            }
            (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
        }
        toDoItems.removeAll()
        tableView.reloadData()
    }
    
    //SWIPES
    //swipe to complete
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = deleteAction(at: indexPath)
        return UISwipeActionsConfiguration(actions: [delete])
    }
    
    func deleteAction(at indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .destructive, title: "Delete") { (action, view, complete) in
            //delete from context
            if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
                
                context.delete(self.toDoItems[indexPath.row])
                
                (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
            }
            //delete from tableview
            self.toDoItems.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            complete(true)
        }
        action.image = UIImage(named: "Trash-can")
        action.backgroundColor = .red
        
        return action
    }
    
    //overriding rightswipe
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        return UISwipeActionsConfiguration(actions: [])
    }
}
