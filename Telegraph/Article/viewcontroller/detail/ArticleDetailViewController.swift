import UIKit
import RxSwift
import RxCocoa

class ArticleDetailViewController: UIViewController, ModelableViewController {

    private lazy var articleDetailViewModel: ArticleDetailViewModel = {
        return self.viewModel as! ArticleDetailViewModel
    }()
    var viewModel: ViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }

    private func setUp() {
        setUpNavigationBarStyle()
    }
    
    private func setUpNavigationBarStyle() {
        self.navigationItem.title = "STAR WARS"
    }

}
