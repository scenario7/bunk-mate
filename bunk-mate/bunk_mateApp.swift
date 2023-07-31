//
//  bunk_mateApp.swift
//  bunk-mate
//
//  Created by Kevin Thomas on 11/07/23.
//

import SwiftUI
import WidgetKit
import Combine
import CoreData


@main
struct bunk_mateApp: App {
    
    private var dataController = DataController.shared
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    let observer = AppObserver(context: DataController.shared.container.viewContext)
    
    var body: some Scene {
        WindowGroup {
            SplashScreenView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}


class AppDelegate : NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        return true
    }
}


class AppObserver {
    private var cancellables: Set<AnyCancellable> = []
    init(context: NSManagedObjectContext) {
        NotificationCenter.Publisher(center: .default, name: .NSManagedObjectContextObjectsDidChange, object: context)
            .sink { _ in
                //WidgetCenter.shared.reloadAllTimelines()
            }
            .store(in: &cancellables)
    }
}

