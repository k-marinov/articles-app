import UIKit

class TelegraphApp: TelegraphAppRoutable {

    private var componentCreatable: ComponentCreatable!

    init(componentCreatable: ComponentCreatable) {
        self.componentCreatable = componentCreatable
    }

    func setUp(with window: UIWindow) {
        UIApplication.shared.statusBarStyle = .lightContent
        _ = setRootViewController(to: window, componentCreatable: componentCreatable)
    }

}
