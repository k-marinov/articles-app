import RxSwift

class ArticlesViewModel: ViewModel {

    private let disposeBag: DisposeBag = DisposeBag()

    private(set) var articlesService: ArticleService!
    private(set) var dataSource: TableViewDataSource<ArticleResource, ArticleCell>
        = TableViewDataSource<ArticleResource, ArticleCell>()

    private(set) var beginRefreshing: PublishSubject<Bool> = PublishSubject<Bool>()
    private(set) var reloadTableView: PublishSubject<Void> = PublishSubject<Void>()


    required init(componentCreatable: ComponentCreatable) {
        articlesService = componentCreatable.create(with: componentCreatable)
    }

    func findAllArticles() -> Observable<Void> {
        return Observable.just(())
    }

}
