//
//  SettingsViewController.swift
//  TODO
//
//  Created by Michał Jarosz on 29/07/2019.
//  Copyright © 2019 Michał Jarosz. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var ClearEvery: UISegmentedControl!
    
    var previousVC = ViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //navigation title
        navigationItem.title = "Settings"
        
        //About button
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "About", style: .plain, target: self, action: #selector(About))
        
        //back button
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(backAction))
    }
    
    //save clear every...
    //ClearEvery.selectedSegmentIndex = 0 -> Never
    //ClearEvery.selectedSegmentIndex = 1 -> Month
    @IBAction func clearEveryChanged(_ sender: Any) {
        
    }
    
    //SEGUE
    //segue to about
    @objc func About() {
        performSegue(withIdentifier: "aboutSegue", sender: nil)
    }
    
    @IBAction func segueHistoryVC(_ sender: Any) {
        performSegue(withIdentifier: "historySegue", sender: nil)
    }
    
    @objc func backAction() {
        reloadPreviousVC()
        self.navigationController?.popViewController(animated: true)
    }
    
    func reloadPreviousVC() {
        previousVC.getToDoItems()
    }
}
