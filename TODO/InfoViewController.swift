//
//  InfoViewController.swift
//  TODO
//
//  Created by Michał Jarosz on 25/07/2019.
//  Copyright © 2019 Michał Jarosz. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {

    @IBOutlet weak var ToDoItemName: UITextField!
    @IBOutlet weak var ToDoItemDescription: UITextView!
    @IBOutlet weak var ToDoItemDateAdded: UILabel!
    
    var toDoItem = ToDoItem()
    var previousVC = ViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        ToDoItemName.text = toDoItem.name
        ToDoItemDescription.text = toDoItem.todo_description
        ToDoItemDateAdded.text = toDoItem.date_str
        //description boarder
        ToDoItemDescription.layer.borderWidth = 0.5
        ToDoItemDescription.layer.borderColor = UIColor.lightGray.cgColor
        
        //delete bar button "image"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "Trash-can"), style: .plain, target: self, action: #selector(deleteToDoItem))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(backAction))
        //back bar button and save changes
//        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "back"), style: .plain, target: self, action: #selector(backAction))
//        navigationItem.leftBarButtonItems?.append(UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(backAction)))
    }
    
    @IBAction func Complete(_ sender: Any) {
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            
            context.object(with: toDoItem.objectID).setValue(true, forKey: "completed")
            
            (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
        }
        backAction()
    }
    
    func editName() {
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            
            context.object(with: toDoItem.objectID).setValue(ToDoItemName.text, forKey: "name")
            
            (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
        }
    }
    
    func editDescription() {
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            
            context.object(with: toDoItem.objectID).setValue(ToDoItemDescription.text, forKey: "todo_description")
            
            (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
        }
    }
    
    @objc func deleteToDoItem() {
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            
            context.delete(toDoItem)
            
            (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
            
            self.navigationController?.popViewController(animated: true)
        }
        reloadPreviousVC()
    }
    
    @objc func backAction() {
        if ToDoItemName.text != toDoItem.name {
            editName()
        }
        if ToDoItemDescription.text != toDoItem.todo_description {
            editDescription()
        }
        reloadPreviousVC()
        self.navigationController?.popViewController(animated: true)
    }
    
    func reloadPreviousVC() {
        previousVC.getToDoItems()
    }
}
