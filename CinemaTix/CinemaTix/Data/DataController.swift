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
//        user.password = password
        
//        let wallet = Wallet(context: context)
//        wallet.id = UUID()
//        wallet.transactions = NSSet(array: [
//            Transac(context: context)
//        ])
//        user.wallet = wallet.id
        
        do {
            try context.save()
            return user
        } catch {
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
                return user
            } else {
                return nil
            }
        } catch {
            return nil
        }
    }
}
