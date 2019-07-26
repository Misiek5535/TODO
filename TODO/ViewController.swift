//
//  ViewController.swift
//  TODO
//
//  Created by Michał Jarosz on 25/07/2019.
//  Copyright © 2019 Michał Jarosz. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var taskTableView: UITableView!
    @IBOutlet weak var newToDoName: UITextField!
    
    var toDoItems : [ToDoItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //about app button
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "About", style: .plain, target: self, action: #selector(AboutApp))
        
        //add button
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(Add))
        //app name
        navigationItem.title = "To Do"
        
        taskTableView.dataSource = self
        taskTableView.delegate = self
        
        getToDoItems()
    }
    
    func getToDoItems() {
        //get to do items from coredata
        
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            
            do {
                //set to class property
                toDoItems = try context.fetch(ToDoItem.fetchRequest())
            } catch {}
        }
        
        taskTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = toDoItems[indexPath.row].name
        return cell
    }
    
    //segue to info
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let sender = toDoItems[indexPath.row]
        performSegue(withIdentifier: "infoSegue", sender: sender)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "infoSegue" {
            let defVC = segue.destination as! InfoViewController
            defVC.toDoItem = sender as! ToDoItem
            defVC.previousVC = self
        } else if segue.identifier == "addSegue" {
            let defVC = segue.destination as! AddViewController
            defVC.previousVC = self
        }
        
        
    }
    
    //segue to add
    @objc func Add() {
        performSegue(withIdentifier: "addSegue", sender: nil)
    }
    
    //segue to about app
    @objc func AboutApp() {
        performSegue(withIdentifier: "aboutSegue", sender: nil)
    }
}

