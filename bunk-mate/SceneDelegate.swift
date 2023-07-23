import SwiftUI
import WidgetKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func sceneDidEnterBackground(_ scene: UIScene) {
        DataController.shared.saveData()
        // Add this line to force a snapshot of the view before updating the widget
        print("did enter background")
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }
    
    // ... Your other SceneDelegate code
}
