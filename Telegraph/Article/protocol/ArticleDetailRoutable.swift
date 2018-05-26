import UIKit

protocol ArticleDetailRoutable: ViewControllerCreatable, Navigation {

    func pushArticleDetailViewController(detail: ArticleDetailRepresentable)

}

extension ArticleDetailRoutable {

    func pushArticleDetailViewController(detail: ArticleDetailRepresentable) {
        let viewController: UIViewController = createViewController(
            withViewModel: ArticleDetailViewModel(detail: detail),
            viewControllerType: ArticleDetailViewController.self)

        self.navigationController()?.pushViewController(viewController, animated: true)
    }

}
