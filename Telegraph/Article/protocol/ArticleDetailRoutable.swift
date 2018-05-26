import UIKit

protocol ArticleDetailRoutable: ViewControllerCreatable {

    func pushArticleDetailViewController(detail: ArticleDetailRepresentable)

}

extension ArticleDetailRoutable {

    func navigationController() -> UINavigationController? {
        for window in UIApplication.shared.windows {
            if let rootViewController: UINavigationController = window.rootViewController as? UINavigationController {
                return rootViewController
            }
        }
        return nil
    }

    func pushArticleDetailViewController(detail: ArticleDetailRepresentable) {
        let viewController: UIViewController = createViewController(
            withViewModel: ArticleDetailViewModel(detail: detail),
            viewControllerType: ArticleDetailViewController.self)

        self.navigationController()?.pushViewController(viewController, animated: true)
    }

}
