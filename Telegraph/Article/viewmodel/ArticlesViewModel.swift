import RxSwift

class ArticlesViewModel: ViewModel, ArticleDetailRoutable {

    private let disposeBag: DisposeBag = DisposeBag()

    private(set) var articlesService: ArticleService!
    private(set) var dataSource: TableViewDataSource<ArticleResource, ArticleCell> =
        TableViewDataSource<ArticleResource, ArticleCell>()
    private(set) var beginRefreshing: PublishSubject<Bool> = PublishSubject<Bool>()
    private(set) var reloadTableView: PublishSubject<Void> = PublishSubject<Void>()

    required init(componentCreatable: ComponentCreatable) {
        articlesService = componentCreatable.create(with: componentCreatable)
        subscribe()
    }

    func subscribe() {
        dataSource.didSelectRowAtIndexPath
            .flatMap { [weak self] indexPath -> Observable<ArticleDetailRepresentable>  in
                guard let `self` = self else { return Observable.empty() }
                return self.detail(from: indexPath)
            }.subscribe(onNext: { [weak self] detail in
                guard let `self` = self else { return }
                self.pushArticleDetailViewController(detail: detail)
            }).disposed(by: disposeBag)
    }

    func loadArticles() -> Observable<Void> {
        return articlesService.findAllArticles(with: ArticlesRequest())
            .observeOn(MainScheduler.instance)
            .do(onNext: { [weak self] newArticles in
                self?.dataSource.appendOnce(contentsOf: newArticles.sorted { $0.rating > $1.rating })
            }, onError: { [weak self] error in
                self?.onLoadArticlesCompleted(with: error as! ApiError)
            }, onCompleted: {  [weak self] in
                self?.onLoadArticlesCompleted()
            }, onSubscribe: { [weak self] in
                self?.onLoadArticlesStarted()
            }).map { _ in return () }
    }

    private func detail(from indexPath: IndexPath) -> Observable<ArticleDetailRepresentable>  {
        let detail: ArticleDetailRepresentable = dataSource.items[indexPath.row] as! ArticleDetailRepresentable
        return Observable<ArticleDetailRepresentable>.just(detail)
    }

    private func onLoadArticlesStarted() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        beginRefreshing.onNext(true)
    }

    private func onLoadArticlesCompleted() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        beginRefreshing.onNext(false)
        reloadTableView.onNext(())
    }

    private func onLoadArticlesCompleted(with error: ApiError) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        beginRefreshing.onNext(false)
        showErrorAlert(with: error)
    }

    private func showErrorAlert(with error: ApiError) {
        let alert = UIAlertController(
            title: "Error: \(error)",
            message: "Please pull to refresh!",
            preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        navigationController()?.present(alert, animated: true, completion: nil)
    }

}
