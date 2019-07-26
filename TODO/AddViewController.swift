//
//  AddViewController.swift
//  TODO
//
//  Created by Michał Jarosz on 25/07/2019.
//  Copyright © 2019 Michał Jarosz. All rights reserved.
//

import UIKit

class AddViewController: UIViewController {

    @IBOutlet weak var newToDoTextField: UITextField!
    @IBOutlet weak var Important: UISwitch!
    
    var previousVC = ViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(Add))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "< Back", style: .plain, target: self, action: #selector(backAction))
    }
    
    @objc func Add() {
        if newToDoTextField.text != "" {
            
            if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {

                let toDoItem = ToDoItem(context: context)
                var name = ""
                if Important.isOn {
                    //not best idea, as it can be deleted when changing name
                    name = "❗️"
                    Important.isEnabled = false
                    toDoItem.important = true
                }

                name += (newToDoTextField.text)!

                toDoItem.name = name
                toDoItem.todo_description = ""

                (UIApplication.shared.delegate as? AppDelegate)?.saveContext()

                ReloadPreviousVC()

                newToDoTextField.text = ""
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    @objc func backAction(){
        self.navigationController?.popViewController(animated: true)
    }
    
    func ReloadPreviousVC() {
        previousVC.getToDoItems()
    }
}
