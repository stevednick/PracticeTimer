//
//  DataStore.swift
//  PracticeTimer
//
//  Created by Stephen Nicholls on 18/05/2022.
//

import Foundation
import CoreData

class DataStore {
    static let shared = DataStore()
    
    let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "PracticeTimer")
        container.loadPersistentStores { description, error in
            if let error = error {
                print(error)
            }
        }
        return container
    }()
    
    private init() {
        
    }

    public func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            }catch {
                print(error)
            }
        }
    }
    
}
