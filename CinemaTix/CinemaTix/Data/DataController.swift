//
//  DataController.swift
//  CinemaTix
//
//  Created by Eky on 12/11/23.
//

import Foundation
import CoreData

class DataController {
    let container = NSPersistentContainer(name: "CinemaTix")
    
    init() {
        container.loadPersistentStores { desc, error in
            if let error = error {
                print("Failed to load the data \(error.localizedDescription)")
            }
        }
    }
    
    func addUser(username: String, email: String, password: String, context: NSManagedObjectContext) -> User? {
        let user = User(context: context)
        user.id = UUID()
        user.username = username
        user.email = email
        user.password = password
        
        do {
            try context.save()
            print("Save to User")
            return user
        } catch {
            print("Failed to save user: \(error)")
            return nil
        }
    }
    
    func getUser(email: String, password: String, context: NSManagedObjectContext) -> User? {
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        
        let predicate = NSPredicate(format: "email == %@ AND password == %@", email, password)
        fetchRequest.predicate = predicate
        
        do {
            let fetchedResults = try context.fetch(fetchRequest)
            
            if let user = fetchedResults.first {
                print("Found user with email: \(user.email ?? "N/A")")
                return user
            } else {
                print("User with email \(email) not found")
                return nil
            }
        } catch {
            print("Error fetching user: \(error.localizedDescription)")
            return nil
        }
    }
    
//    func deleteAllUser(context: NSManagedObjectContext) {
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
//        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
//        
//    }
}
