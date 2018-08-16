//
//  ViewController.swift
//  CoreData Fun
//
//  Created by Laszlo on 8/13/18.
//  Copyright © 2018 Laszlo. All rights reserved.


import UIKit
import CoreData

var projectNames: [String]?
var projectName: String?
var rowIndex = 0

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var db = DbHelperCoreData()
    var dbTableName = "Projects"
    var dbFieldName = "projectName"

    
    @IBOutlet weak var newProjectTextView: UITextField!
    @IBAction func saveButton(_ sender: UIButton) {
        let projectName = newProjectTextView.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        if (projectName?.isEmpty)! {
            newProjectTextView.backgroundColor = UIColor.red.withAlphaComponent(0.2)
            return
        }
        let newProject = Projects(context: db.context)
        newProject.projectName = projectName
        db.addNewItem(item: newProject)
        
        //Clean-up
        newProjectTextView.text = ""
        newProjectTextView.backgroundColor = UIColor.red.withAlphaComponent(0)
        refreshTableContent()
        //print("There are now: \((projectNames?.endIndex)!) items.")
        if projectTableView.numberOfRows(inSection: 0) > 0 {
            let indexOfLastRow = projectTableView.numberOfRows(inSection: 0) - 1
            let indexPath = IndexPath(row: indexOfLastRow, section: 0)
            self.projectTableView.scrollToRow(at: indexPath, at: .middle, animated: true)
        }

    }
    
    
    @IBOutlet weak var projectTableView: UITableView!
    //  When you set up the table view, you must control-grab in story board from the table view to the top circle-square button and choose Outlets: >DataSource and >Delegate.
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        db = DbHelperCoreData()
        //delete item 2
        //db.deleteItem(atIndex: 2)
        refreshTableContent()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func refreshTableContent() {
        projectNames = db.retrieveAllProjects()
        self.projectTableView.reloadData()
        
    }
    
    func tableView(_ projectTableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return projectNames!.count
    }
    
    func tableView(_ projectTableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
        cell.textLabel?.text = projectNames![indexPath.row]
        return cell
    }
    
    func tableView(_ projectTableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        rowIndex = indexPath.row
        print("You have activated row: \(rowIndex)")
        //performSegue(withIdentifier: "segue", sender: self)
    }

}

