import RxSwift

@testable import Telegraph

class MockArticleService: ArticleService {

    var isRequestSuccess = false

    override func findAllArticles(with request: ArticlesRequest) -> Observable<[ArticleResource]> {
        return isRequestSuccess
        ? Observable.just(ArticleMother.createArticles().articles)
        : Observable.error(ApiError.client)
    }

}
