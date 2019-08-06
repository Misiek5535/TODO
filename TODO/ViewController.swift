//
//  ViewController.swift
//  TODO
//
//  Created by Michał Jarosz on 25/07/2019.
//  Copyright © 2019 Michał Jarosz. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var taskTableView: UITableView!
    
    var toDoItems : [ToDoItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //settings button -> settings VC -> about VC
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "settings-2"), style: .plain, target: self, action: #selector(Settings))
        
        //add button
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(Add))
        
        //app name
        navigationItem.title = "To Do"
        
        taskTableView.dataSource = self
        taskTableView.delegate = self
        
        getToDoItems()
    }
    
    //COREDATA
    func getToDoItems() {
        //get to do items from coredata
        
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            
            do {
                toDoItems = try context.fetch(ToDoItem.fetchRequest())
            } catch {}
        }
        
        for todoitem in toDoItems {
            if todoitem.completed == true {
                let index = toDoItems.firstIndex(of: todoitem)!
                toDoItems.remove(at: index)
            }
        }
        
        taskTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count = 0;

        for todoitem in toDoItems {
            if !todoitem.completed {
                count += 1
            }
        }

        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = toDoItems[indexPath.row].name
        return cell
    }
    
    
    //SEGUE
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "infoSegue" {
            let defVC = segue.destination as! InfoViewController
            defVC.toDoItem = sender as! ToDoItem
            defVC.previousVC = self
        } else if segue.identifier == "addSegue" {
            let defVC = segue.destination as! AddViewController
            defVC.previousVC = self
        } else if segue.identifier == "settingsSegue" {
            let defVC = segue.destination as! SettingsViewController
            defVC.previousVC = self
        }
    }
    
    //segue to info
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let sender = toDoItems[indexPath.row]
        performSegue(withIdentifier: "infoSegue", sender: sender)
    }
    
    //segue to add
    @objc func Add() {
        performSegue(withIdentifier: "addSegue", sender: nil)
    }
    
    //segue to settings
    @objc func Settings() {
        performSegue(withIdentifier: "settingsSegue", sender: nil)
    }
    
    //SWIPES
    //swipe to complete
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let complete = completeAction(at: indexPath)
        
        return UISwipeActionsConfiguration(actions: [complete])
    }
    
    func completeAction(at indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .destructive, title: "Complete") { (action, view, complete) in
            //delete from context
            if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
                
                let toDoItem = self.toDoItems[indexPath.row]
                context.object(with: toDoItem.objectID).setValue(true, forKey: "completed")
                
                (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
            }
            //delete from tableview
            self.toDoItems.remove(at: indexPath.row)
            self.taskTableView.deleteRows(at: [indexPath], with: .automatic)
            complete(true)
        }
        action.image = UIImage(named: "Check")
        action.backgroundColor = .green
        
        return action
    }
    
    //override swipe to not show delete
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        return UISwipeActionsConfiguration(actions: [])
    }
}

