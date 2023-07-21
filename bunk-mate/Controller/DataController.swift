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

    }
    
    func saveData(){
        if container.viewContext.hasChanges {
            do {
                print("Saved")
                try container.viewContext.save()
                WidgetCenter.shared.reloadAllTimelines()
                let currentDate = Date()
                let userDefaults = UserDefaults.standard
                userDefaults.set(currentDate, forKey: "lua")
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
