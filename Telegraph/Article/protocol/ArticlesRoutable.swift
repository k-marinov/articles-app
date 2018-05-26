import UIKit

protocol ArticlesRoutable: ViewControllerCreatable, Navigation {

    func setArticlesViewControllerAsRoot(to window: UIWindow, componentCreatable: ComponentCreatable) -> UIWindow

}

extension ArticlesRoutable {

    func setArticlesViewControllerAsRoot(to window: UIWindow, componentCreatable: ComponentCreatable) -> UIWindow {
        let viewController: UIViewController = createViewController(
            withViewModel: ArticlesViewModel(componentCreatable: componentCreatable),
            viewControllerType: ArticlesViewController.self)
        window.rootViewController = rootNavigationController(rootViewController: viewController)
        window.makeKeyAndVisible()
        return window
    }

    private func rootNavigationController(rootViewController: UIViewController) -> UINavigationController {
        let navigationController: UINavigationController = UINavigationController(rootViewController: rootViewController)
        navigationController.navigationBar.tintColor = UIColor.white
        navigationController.navigationBar.isTranslucent = false
        navigationController.navigationBar.barTintColor = UIColor.black
        navigationController.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
        return navigationController
    }

}
