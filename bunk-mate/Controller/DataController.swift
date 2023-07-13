//
//  DataController.swift
//  bunk-mate
//
//  Created by Kevin Thomas on 13/07/23.
//

import SwiftUI
import CoreData

class DataController : ObservableObject {
    let container = NSPersistentContainer(name: "Stash")
    
    init(){
        container.loadPersistentStores { descripion, error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
}
