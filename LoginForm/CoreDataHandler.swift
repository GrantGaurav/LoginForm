//
//  CoreDataHandler.swift
//  LoginForm
//
//  Created by Grant Gaurav on 2/14/18.
//  Copyright © 2018 Grant Gaurav. All rights reserved.
//

import UIKit
import CoreData

class CoreDataHandler: NSObject {
    private class func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    class func saveObject(firstname: String, lastname: String, standard: String, age: String, dateofbirth: String) -> Bool {
        let context = getContext()
        let entity = NSEntityDescription.entity(forEntityName: "Users", in: context)
        let managedObject = NSManagedObject(entity: entity!, insertInto: context)
        managedObject.setValue(firstname, forKey: "firstname")
        managedObject.setValue(lastname, forKey: "lastname")
        managedObject.setValue(standard, forKey: "standard")
        managedObject.setValue(age, forKey: "age")
        managedObject.setValue(dateofbirth, forKey: "dateofbirth")
        do{
            try context.save()
            print("saved")
            return true
        }
        catch {
            print("error")
            return false
        }
    }
    
    class func fetchObject(filter: String? = nil) -> [Users]? {
        let context = getContext()
        var user: [Users]? = nil
        do {
            user = try context.fetch(Users.fetchRequest())
            return user
        }
        catch {
            return user
        }
    }
    /*class func fetchData(filter: String? = nil){
        let context = getContext()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key:filter, ascending: true)]
        fetchRequest.predicate = NSPredicate(format: "firstname = %@", "Gaurav")
        do {
            let result = try context.fetch(fetchRequest) as! [Users]
            return result
        }
        catch {
            print("error")
            
        }
    }*/
    
    class func deleteObject(user: Users) ->Bool {
        let context = getContext()
        context.delete(user)
        do {
           try context.save()
            return true
        }
        catch {
            return false
        }
    }
    
    class func cleanData() -> Bool {
        let context = getContext()
        let delete = NSBatchDeleteRequest(fetchRequest: Users.fetchRequest())
        do {
            try context.execute(delete)
            return true
        }
        catch {
            return false
        }
    }
}
