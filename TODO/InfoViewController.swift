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
    @IBOutlet weak var ToDoItemDescription: UITextField!
    
    var toDoItem = ToDoItem()
    var previousVC = ViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        ToDoItemName.text = toDoItem.name
        ToDoItemDescription.text = toDoItem.todo_description
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "< Back", style: .plain, target: self, action: #selector(backAction))
        
        //let deleteImage = UIImage(named: "rubbish-bin")
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Delete", style: .plain, target: self, action: #selector(deleteToDoItem))
//        navigationItem.rightBarButtonItem = UIBarButtonItem(image: deleteImage, style: .plain, target: self, action: #selector(deleteToDoItem))
    }
    
    @IBAction func CompleteToDO(_ sender: Any) {
        deleteToDoItem()
    }
    
    func editName() {
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            
            context.object(with: toDoItem.objectID).setValue(ToDoItemName.text, forKey: "name")
            
            (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
            ReloadPreviousVC()
        }
    }
    
    func editDescription() {
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            
            context.object(with: toDoItem.objectID).setValue(ToDoItemDescription.text, forKey: "todo_description")
            
            (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
            ReloadPreviousVC()
        }
    }
    
    @objc func deleteToDoItem() {
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            
            context.delete(toDoItem)
            
            (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
            
            ReloadPreviousVC()
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @objc func backAction() {
        if ToDoItemName.text != toDoItem.name {
            editName()
        }
        
        if ToDoItemDescription.text != toDoItem.todo_description {
            editDescription()
        }
        
        self.navigationController?.popViewController(animated: true)
    }
    
    func ReloadPreviousVC() {
        previousVC.getToDoItems()
    }
}
