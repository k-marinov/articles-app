import Quick
import Nimble
import RxSwift

@testable import Telegraph

class ArticlesViewModelPushDetailSpec: QuickSpec {

    override func spec() {

        describe("ArticlesViewModel") {
            let disposeBag: DisposeBag = DisposeBag()
            let creator: MockComponentCreator = MockComponentCreator.buildAllMocks()
            let viewModel: ArticlesViewModel = ArticlesViewModel(componentCreatable: creator)
            var tableView: UITableView!

            describe("didSelectRowAtIndexPath") {
                context("when first table view item is selected") {
                    beforeEach {
                        tableView = self.setUpMockTableView(viewModel: viewModel)
                        self.setUpMockWindow()
                        waitUntil(timeout: 10.0) { done in
                            viewModel.dataSource.didSelectRowAtIndexPath.subscribe(onNext: { IndexPath in
                                done()
                            }, onCompleted: {
                                done()
                            }).disposed(by: disposeBag)
                            viewModel.dataSource.tableView(tableView, didSelectRowAt: IndexPath(row: 0, section: 0))
                        }
                    }

                    it("pushes article detail view controller") {
                        expect(viewModel.navigationController()?.childViewControllers.last!)
                            .to(beAKindOf(ArticleDetailViewController.self))
                    }
                }
            }
        }
    }

    private func setUpMockTableView(viewModel: ArticlesViewModel) -> UITableView {
        let articles: [ArticleResource] = [ArticleMother.createArticle()]
        let tableView: UITableView = UITableView(frame: CGRect(x: 0.0, y: 0.0, width: 320.0, height: 568.0))
        viewModel.dataSource.appendOnce(contentsOf: articles)

        tableView.register(
            UINib(nibName: ArticleCell.identifier, bundle: nil),
            forCellReuseIdentifier: ArticleCell.identifier)
        tableView.rowHeight = 50.0
        tableView.estimatedRowHeight = 50.0
        tableView.dataSource = viewModel.dataSource
        tableView.delegate = viewModel.dataSource
        tableView.reloadData()

        return tableView
    }

    private func setUpMockWindow() {
        let window: UIWindow = UIWindow(frame: UIScreen.main.bounds)
        window.makeKeyAndVisible()
        UIApplication.shared.windows[0].rootViewController = UINavigationController()
        UIApplication.shared.windows[0].makeKeyAndVisible()
    }

}
