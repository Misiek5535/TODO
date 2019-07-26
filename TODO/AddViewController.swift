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
                toDoItem.name = newToDoTextField.text

                (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
                
                newToDoTextField.text = ""
                _ = navigationController?.popToRootViewController(animated: true)
            }
        }
    }
    
    @IBAction func addClicked(_ sender: Any) {
        
        if newToDoTextField.text != "" {
            
            if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
                
                let toDoItem = ToDoItem(context: context)
                toDoItem.name = newToDoTextField.text
                
                (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
                
                newToDoTextField.text = ""
                
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    @objc func backAction(){
        self.navigationController?.popViewController(animated: true)
    }
}
