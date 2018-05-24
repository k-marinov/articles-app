import UIKit
import RxSwift

protocol TelegraphAppRoutable: class {

    func setRootViewController(to window: UIWindow, componentCreatable: ComponentCreatable) -> UIWindow

}

extension TelegraphAppRoutable {

    func setRootViewController(to window: UIWindow, componentCreatable: ComponentCreatable) -> UIWindow {
        return setArticlesViewControllerAsRoot(to: window, componentCreatable: componentCreatable)
    }

}
