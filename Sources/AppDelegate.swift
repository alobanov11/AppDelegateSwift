//
//  Created by Антон Лобанов on 27.03.2023.
//

import UIKit

open class AppDelegate: UIResponder, UIApplicationDelegate {
	public var window: UIWindow?

	open var services: [AppDelegateService] = []

	public func application(
		_ application: UIApplication,
		didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
	) -> Bool {
		self.services.map {
			$0.application?(application, didFinishLaunchingWithOptions: launchOptions) ?? true
		}.contains(true)
	}

	public func applicationWillResignActive(_ application: UIApplication) {
		self.services.forEach { $0.applicationWillResignActive?(application) }
	}

	public func applicationWillEnterForeground(_ application: UIApplication) {
		self.services.forEach { $0.applicationWillEnterForeground?(application) }
	}

	public func applicationDidEnterBackground(_ application: UIApplication) {
		self.services.forEach { $0.applicationDidEnterBackground?(application) }
	}

	public func applicationDidBecomeActive(_ application: UIApplication) {
		self.services.forEach { $0.applicationDidBecomeActive?(application) }
	}

	public func applicationWillTerminate(_ application: UIApplication) {
		self.services.forEach { $0.applicationWillTerminate?(application) }
	}

	public func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
		self.services.map {
			$0.application?(app, open: url, options: options) ?? false
		}.contains(true)
	}

	public func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
		self.services.map {
			$0.application?(application, open: url, sourceApplication: sourceApplication, annotation: annotation) ?? false
		}.contains(true)
	}

	public func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
		self.services.forEach {
			$0.application?(application, didRegisterForRemoteNotificationsWithDeviceToken: deviceToken)
		}
	}

	public func application(
		_ application: UIApplication,
		continue userActivity: NSUserActivity,
		restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void
	) -> Bool {
		self.services.map {
			$0.application?(application, continue: userActivity, restorationHandler: restorationHandler) ?? false
		}.contains(true)
	}

	public func application(
		_ application: UIApplication,
		supportedInterfaceOrientationsFor window: UIWindow?
	) -> UIInterfaceOrientationMask {
		self.services.compactMap { $0.application?(application, supportedInterfaceOrientationsFor: window) }.first ?? .portrait
	}
}
