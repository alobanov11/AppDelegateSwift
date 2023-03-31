//
//  Created by Антон Лобанов on 31.03.2023.
//

import UIKit

public protocol SceneService: UIWindowSceneDelegate {}

open class Scene: UIResponder, UIWindowSceneDelegate {
    public var window: UIWindow?

    open var services: [SceneService] = []

    public func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        self.services.forEach { $0.scene?(scene, willConnectTo: session, options: connectionOptions) }
    }

    public func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        self.services.forEach { $0.scene?(scene, openURLContexts: URLContexts) }
    }

    public func sceneDidDisconnect(_ scene: UIScene) {
        self.services.forEach { $0.sceneDidDisconnect?(scene) }
    }

    public func sceneDidBecomeActive(_ scene: UIScene) {
        self.services.forEach { $0.sceneDidBecomeActive?(scene) }
    }

    public func sceneWillResignActive(_ scene: UIScene) {
        self.services.forEach { $0.sceneWillResignActive?(scene) }
    }

    public func sceneWillEnterForeground(_ scene: UIScene) {
        self.services.forEach { $0.sceneWillEnterForeground?(scene) }
    }

    public func sceneDidEnterBackground(_ scene: UIScene) {
        self.services.forEach { $0.sceneDidEnterBackground?(scene) }
    }

    public func windowScene(_ windowScene: UIWindowScene, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        self.services.forEach { $0.windowScene?(windowScene, performActionFor: shortcutItem, completionHandler: completionHandler) }
    }

    public func scene(_ scene: UIScene, continue userActivity: NSUserActivity) {
        self.services.forEach { $0.scene?(scene, continue: userActivity) }
    }
}

public extension SceneService {
    @nonobjc
    var window: UIWindow? {
        get {
            (UIApplication.shared.connectedScenes.first?.delegate as? Scene)?.window
        }
        set {
            (UIApplication.shared.connectedScenes.first?.delegate as? Scene)?.window = newValue
        }
    }
}
