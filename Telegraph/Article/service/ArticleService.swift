import RxSwift

class ArticleService: Service {

    private var articleRemote: ArticleRemote

    required init(componentCreatable: ComponentCreatable) {
        articleRemote = componentCreatable.create(with: componentCreatable)
    }

    func findAllArticles(with request: ArticlesRequest) -> Observable<[ArticleResource]> {
        return articleRemote.findAllArticles(with: request)
    }

}
