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
    
    var toDoItem = ToDoItem()
    var previousVC = ViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        ToDoItemName.text = toDoItem.name
        
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
        
        self.navigationController?.popViewController(animated: true)
    }
    
    func ReloadPreviousVC() {
        previousVC.getToDoItems()
    }
}
