//
//  DbHelperCoreData.swift
//  CoreData Fun
//
//  Created by Laszlo on 8/13/18.
//  Copyright © 2018 Laszlo. All rights reserved.
//

import UIKit
import CoreData

class DbHelperCoreData {

    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    //can try saveContext() as well -- in AppDelegate
    func addNewItem (item: Any) {
        do {
            try context.save()
            print ("\nSaved new item.")
        } catch {
            print("There was an error when trying to save.")
        }
    }
    
    // TODO: may make it more general not only Projects
    func deleteItem (atIndex: Int) {
        var results : [Projects] = []
        let request: NSFetchRequest<Projects> = Projects.fetchRequest()
        request.returnsObjectsAsFaults = false
        do {
            results = try context.fetch(request)
            let item = results[atIndex]
            context.delete(item)
        } catch {
            print("Error deleting item.")
        }
        do {
            try context.save()
        } catch {
            print("There was an error when trying to save the context.")
        }
    }
    
    func retrieveAllProjects () -> [String] {
        var itemsList: [String] = []
        //Cannot be optional: unwrapping will find nil and crash
        
        let request: NSFetchRequest<Projects> = Projects.fetchRequest()
        request.returnsObjectsAsFaults = false
        
        do {
            let results = try context.fetch(request)
            if !(results.isEmpty) {
                for result in results {
                    if let projectName = result.projectName {
                        itemsList.append(projectName)
                    }
                }
            } else {
                print ("DB was empty")
            }
        } catch {
            print("There was an error retrieving stuff")
        }
        
        return (itemsList)
    }
    

}
