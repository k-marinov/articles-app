import UIKit
import RxSwift
import RxCocoa

class ArticlesViewController: UIViewController, ModelableViewController {

    private(set) lazy var refreshControl: UIRefreshControl = {
        let refreshControl: UIRefreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Retrieving latest articles...")
        return refreshControl
    }()

    private lazy var pricingViewModel: ArticlesViewModel = {
        return self.viewModel as! ArticlesViewModel
    }()
    var viewModel: ViewModel!

}
