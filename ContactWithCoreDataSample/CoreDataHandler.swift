//
//  CoreDataHandler.swift
//  coreDataApp
//
//  Created by Yash Patel on 24/10/17.
//  Copyright © 2017 Yash Patel. All rights reserved.
//

import UIKit
import CoreData

class CoreDataHandler: NSObject {
    
    private class func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        return appDelegate.persistentContainer.viewContext
    }
    
    class func saveObject(firstname:String, lastname:String, email:String, mobileNo:String, contactimage : NSData) -> Bool {
        let context = getContext()
        let entity = NSEntityDescription.entity(forEntityName: "Contacts", in: context)
        let manageObject = NSManagedObject(entity: entity!, insertInto: context)

        manageObject.setValue(mobileNo, forKey: "mob_number")
        manageObject.setValue(lastname, forKey: "last_name")
        manageObject.setValue(firstname, forKey: "first_name")
        manageObject.setValue(email, forKey: "email")
        manageObject.setValue(contactimage, forKey: "contact_image")
        
        do {
            try context.save()
            return true
        }catch {
            return false
        }
    }
    

    
    class func fetchObject() -> [Contacts]? {
        let context = getContext()
        var contacts:[Contacts]? = nil
        do {
           contacts =  try context.fetch(Contacts.fetchRequest())
            return contacts
        } catch  {
            return nil
        }
    }
    //MARK: - Video Part 2
    class func deleteObject(Contacts1: Contacts) -> Bool {
    
        let context = getContext()
        context.delete(Contacts1)
        
        do {
            try context.save()
            return true
        }catch {
            return false
        }
        
    }
    
    class func cleanDelete() -> Bool {
        let context = getContext()
        let delete = NSBatchDeleteRequest(fetchRequest: Contacts.fetchRequest())
        
        do {
            try context.execute(delete)
            return true
        }catch {
            return false
        }
    }
    
    //MARK: - Video Part 3
    class func filterData() -> [Contacts]? {
        let context = getContext()
        let fetchRequest:NSFetchRequest<Contacts> = Contacts.fetchRequest()
        var contacts1:[Contacts]? = nil
        
        let predicate = NSPredicate(format: "password contains[c] %@", "2")
        fetchRequest.predicate = predicate
        
        do {
            contacts1 = try context.fetch(fetchRequest)
            return contacts1
            
        }catch {
            return contacts1
        }
    }
}








