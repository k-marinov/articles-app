import RxSwift

class ArticleRemote {

    private let apiClient: ApiClient

    required init(componentCreatable: ComponentCreatable) {
        apiClient = componentCreatable.create(with: componentCreatable)
    }

    func findAllArticles(with request: ArticlesRequest) -> Observable<[ArticleResource]> {
        return apiClient.request(with: request)
            .map { ($0.resource as! ArticlesResource).articles }
    }

}
