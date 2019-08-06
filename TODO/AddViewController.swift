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
        
        navigationItem.leftBarButtonItems?.append(UIBarButtonItem(image: UIImage(named: "back"), style: .plain, target: self, action: #selector(backAction)))
        navigationItem.leftBarButtonItems?.append(UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(backAction)))
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
                toDoItem.completed = false
                let date = CurrentDate()
                toDoItem.date_str = dateToStr(date: date)
                toDoItem.date_date = date

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
    
    func CurrentDate() -> Date {
        return Date()
    }
    
    func dateToStr(date: Date) -> String {
        let date = Date()
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "dd-MM-yyyy"
        return dateformatter.string(from: date)
    }
}
