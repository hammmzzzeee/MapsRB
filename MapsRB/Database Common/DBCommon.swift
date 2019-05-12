//
//  DBCommon.swift
//  MapsRB
//
//  Created by HAMZA on 11/05/2019.
//  Copyright © 2019 HAMZA. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class DBCommon{

    static let shared = DBCommon()

    var nsManagedObject: [NSManagedObject] = []

func save(name: String,email: String) {
    
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
    }
    let managedContext = appDelegate.persistentContainer.viewContext
    let entity = NSEntityDescription.entity(forEntityName: "User",
                                   in: managedContext)!
    let user = NSManagedObject(entity: entity,
                                 insertInto: managedContext)


    user.setValue(name, forKeyPath: "name")
    user.setValue(email, forKeyPath: "email")

    do {
        try managedContext.save()
        nsManagedObject.append(user)
    } catch let error as NSError {
        print("Could not save. \(error), \(error.userInfo)")
    }

}
    
    
    
    func fetchData()->Location{
        let loc = Location()

        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                let loc = Location()
                return loc
        }
        
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "User")
        
        do {
            
            nsManagedObject = try managedContext.fetch(fetchRequest)
            
            for result in nsManagedObject as [NSManagedObject]{
                
                loc.username = result.value(forKey: "name")! as! String
                loc.email = result.value(forKey: "email")! as! String
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return loc
    }
    
}
