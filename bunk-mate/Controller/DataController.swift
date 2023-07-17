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

class DataController : ObservableObject {
    
    static let shared = DataController()
    
    let container = NSPersistentContainer(name: "Stash")
        
    @Published var subjects : [Subject] = []
    
    init(){
        
        let url = URL.storeURL(for: "group.com.kevinthomas.bunk-mate", database: "Stash")
        let storeDescription = NSPersistentStoreDescription(url: url)
        container.persistentStoreDescriptions.append(storeDescription)
        
        guard let description = container.persistentStoreDescriptions.first else {
            fatalError("No descriptions found")
        }
        
        //description.setOption(true as NSObject, forKey: NSPersistentStoreRemoteChangeNotificationPostOptionKey)
        
        
        container.loadPersistentStores { descripion, error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
        
        
        container.viewContext.automaticallyMergesChangesFromParent = true
        //container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        
        //NotificationCenter.default.addObserver(self, selector: #selector(self.processUpdate), name: .NSPersistentStoreRemoteChange, object: nil)
    }
    
    @objc
    func processUpdate(notification : NSNotification) {
        operationQueue.addOperation{
            
            let context = self.container.newBackgroundContext()
            context.performAndWait {
                let subjects : [Subject]
                do {
                    try subjects = context.fetch(Subject.fetchRequest())
                    WidgetCenter.shared.reloadAllTimelines()
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
    
    lazy var operationQueue : OperationQueue = {
        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 1
        return queue
    }()
    
    func saveData(){
        if container.viewContext.hasChanges {
            do {
                try container.viewContext.save()
                let currentDate = Date()
                let userDefaults = UserDefaults.standard
                userDefaults.set(currentDate, forKey: "lua")
                WidgetCenter.shared.reloadAllTimelines()
                UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
                
            } catch {
                
            }
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
