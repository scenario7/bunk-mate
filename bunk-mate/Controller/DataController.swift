//
//  DataController.swift
//  bunk-mate
//
//  Created by Kevin Thomas on 13/07/23.
//

import SwiftUI
import CoreData
import CloudKit
import WidgetKit

class DataController {
    
    static let shared = DataController()
    
    let container = NSPersistentContainer(name: "Stash")
            
    init(){
        
        let url = URL.storeURL(for: "group.com.kevinthomas.bunk-mate", database: "Stash")
        let storeDescription = NSPersistentStoreDescription(url: url)
        container.persistentStoreDescriptions.removeAll()
        container.persistentStoreDescriptions.append(storeDescription)
        print("STORE DESCRIPTIONS ARE", container.persistentStoreDescriptions)
        
        
        container.loadPersistentStores { descripion, error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
        
        
        container.viewContext.automaticallyMergesChangesFromParent = true
        

        NotificationCenter.default.addObserver(self, selector: #selector(self.processUpdate), name: .NSPersistentStoreRemoteChange, object: nil)

    }
    
    @objc
    func processUpdate(notification : NSNotification) {
        operationQueue.addOperation{
            
            let context = self.container.newBackgroundContext()
            context.performAndWait {
                let subjects : [Subject]
                do {
                    try subjects = context.fetch(Subject.fetchRequest())
                    
                    print("Processed")
                } catch {
                    fatalError("Error in operation queue")
                }
                
                if context.hasChanges {
                    do {
                        try context.save()
                    } catch {
                        fatalError("Error saving to cloud")
                    }
                }
            }
            
        }
    }
    
    lazy var operationQueue: OperationQueue = {
       var queue = OperationQueue()
        queue.maxConcurrentOperationCount = 1
        return queue
    }()
    
    func saveData(){
        if container.viewContext.hasChanges {
            do {
                print("Saved")
                try container.viewContext.save()
                let currentDate = Date()
                let userDefaults = UserDefaults.standard
                userDefaults.set(currentDate, forKey: "lua")
                UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
            } catch {
                
            }
            WidgetCenter.shared.reloadAllTimelines()
        }

    }
}

public extension URL {
    static func storeURL(for appGroup : String, database : String) -> URL {
        guard let fileContainer = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: appGroup) else {
            fatalError("Unable to create")
        }
        return fileContainer.appendingPathComponent("\(database).sqlite")
    }
}
