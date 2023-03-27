import UIKit

public protocol AppDelegateService: UIApplicationDelegate {
}

public extension AppDelegateService {
	@nonobjc
	var window: UIWindow? {
		get {
			(UIApplication.shared.delegate as? AppDelegate)?.window
		}
		set {
			(UIApplication.shared.delegate as? AppDelegate)?.window = newValue
		}
	}
}
