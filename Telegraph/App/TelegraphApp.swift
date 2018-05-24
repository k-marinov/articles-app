import UIKit

class TelegraphApp: TelegraphAppRoutable {

    private var componentCreatable: ComponentCreatable!

    init(componentCreatable: ComponentCreatable) {
        self.componentCreatable = componentCreatable
    }

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?,
        window: UIWindow) {

        _ = setRootViewController(to: window, componentCreatable: componentCreatable)
    }

}
