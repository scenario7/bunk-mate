//
//  bunk_mateApp.swift
//  bunk-mate
//
//  Created by Kevin Thomas on 11/07/23.
//

import SwiftUI

@main
struct bunk_mateApp: App {
    
    @StateObject private var dataController = DataController.shared
    
    var body: some Scene {
        WindowGroup {
            HomeScreen()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
