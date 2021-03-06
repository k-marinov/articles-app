import UIKit
import RxSwift
import RxCocoa

class ArticlesViewController: UIViewController, ModelableViewController {

    private let disposeBag: DisposeBag = DisposeBag()

    private(set) lazy var refreshControl: UIRefreshControl = {
        let refreshControl: UIRefreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(
            string: "Retrieving latest articles...",
            attributes: [.foregroundColor: UIColor.lightGray])
        refreshControl.tintColor = UIColor.lightGray
        return refreshControl
    }()
    @IBOutlet weak var tableView: UITableView!

    private lazy var articlesViewModel: ArticlesViewModel = {
        return self.viewModel as! ArticlesViewModel
    }()
    var viewModel: ViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        subscribe()
        articlesViewModel.loadArticles()
            .subscribe()
            .disposed(by: disposeBag)
    }

    private func setUp() {
        setUpNavigationBarTitle()
        setUpTableView()
    }

    private func setUpNavigationBarTitle() {
        navigationItem.title = "Articles"
    }

    private func setUpTableView() {
        tableView.dataSource = articlesViewModel.dataSource
        tableView.delegate = articlesViewModel.dataSource
        tableView.backgroundView = refreshControl
        tableView.register(
            UINib(nibName: ArticleCell.identifier, bundle: nil),
            forCellReuseIdentifier: ArticleCell.identifier)
    }

    private func subscribe() {
        articlesViewModel.beginRefreshing
            .asObservable()
            .subscribe(onNext: { [weak self] shouldBeginRefreshing in
                self?.beginOrEndRefreshing(shouldBeginRefreshing)
            }).disposed(by: disposeBag)

        refreshControl.rx.controlEvent([UIControlEvents.valueChanged])
            .asObservable()
            .subscribe(onNext: { [weak self] _ in
                guard let `self` = self else { return }
                self.articlesViewModel.loadArticles()
                    .subscribe()
                    .disposed(by: self.disposeBag)
            }).disposed(by: disposeBag)

        articlesViewModel.reloadTableView
            .asObservable()
            .subscribe(onNext: { [weak self] _ in
                self?.tableView.reloadData()
            }).disposed(by: disposeBag)

    }

    func beginOrEndRefreshing(_ beginRefreshing: Bool) {
        if beginRefreshing {
            let offset: CGPoint = CGPoint(x: 0.0, y: -refreshControl.frame.height)
            tableView.setContentOffset(offset, animated: true)
            refreshControl.beginRefreshing()
        } else {
            let offset: CGPoint = CGPoint(x: 0.0, y: 0)
            tableView.setContentOffset(offset, animated: true)
            refreshControl.endRefreshing()
        }
    }

}
