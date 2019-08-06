//
//  CompletedInfoViewController.swift
//  TODO
//
//  Created by Michał Jarosz on 05/08/2019.
//  Copyright © 2019 Michał Jarosz. All rights reserved.
//

import UIKit

class CompletedInfoViewController: UIViewController {

    @IBOutlet weak var ToDoItemNameTextField: UITextField!
    @IBOutlet weak var ToDoItemDescriptionTextView: UITextView!
    @IBOutlet weak var ToDoItemDateLabel: UILabel!
    
    var toDoItem = ToDoItem()
    var previousVC = HistoryViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        ToDoItemNameTextField.text = toDoItem.name
        ToDoItemDescriptionTextView.text = toDoItem.todo_description
        ToDoItemDateLabel.text = toDoItem.date_str
        //description boarder
        ToDoItemDescriptionTextView.layer.borderWidth = 0.5
        ToDoItemDescriptionTextView.layer.borderColor = UIColor.lightGray.cgColor
        
        //navigation items
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "Trash-can"), style: .plain, target: self, action: #selector(deleteToDo))
        let backbutton = navigationItem.backBarButtonItem
        backbutton?.action = #selector(backAction)
    }
    
    @IBAction func AddBack(_ sender: Any) {
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            
            context.object(with: toDoItem.objectID).setValue(false, forKey: "completed")
            
            (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
        }
        backAction()
    }
    
    func editName() {
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            
            context.object(with: toDoItem.objectID).setValue(ToDoItemNameTextField.text, forKey: "name")
            
            (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
            ReloadPreviousVC()
        }
    }
    
    func editDescription() {
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            
            context.object(with: toDoItem.objectID).setValue(ToDoItemDescriptionTextView.text, forKey: "todo_description")
            
            (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
            ReloadPreviousVC()
        }
    }
    
    @objc func backAction() {
        if ToDoItemNameTextField.text != toDoItem.name {
            editName()
        }
        if ToDoItemDescriptionTextView.text != toDoItem.todo_description {
            editDescription()
        }
        ReloadPreviousVC()
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func deleteToDo() {
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            
            context.delete(toDoItem)
            
            (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
        }
        ReloadPreviousVC()
        self.navigationController?.popViewController(animated: true)
    }
    
    func ReloadPreviousVC() {
        previousVC.getToDoItems()
    }
}
