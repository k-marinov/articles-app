import Quick
import Nimble
import RxSwift

@testable import Telegraph

class ArticleServiceSpec: QuickSpec {

    private let mocker: ArticleHttpMocker = ArticleHttpMocker()

    override func setUp() {
        super.setUp()
        mocker.setUpStubs()
    }

    override func tearDown() {
        mocker.removeStubs()
        super.tearDown()
    }

    override func spec() {
        describe("ArticleService") {
            let disposeBag: DisposeBag = DisposeBag()
            let service: ArticleService = ArticleService(componentCreatable: ComponentCreator())

            describe("findAllArticles") {
                var articles: [ArticleResource] = [ArticleResource]()

                beforeEach {
                    articles.removeAll()
                }

                afterEach {
                    articles.removeAll()
                }

                context("when articles request is success") {
                    beforeEach {
                        ArticleHttpMocker.scenario = ArticleHttpMocker.Scenario.success

                        waitUntil(timeout: 10) { done in
                            service.findAllArticles(with: ArticlesRequest())
                                .subscribe(onNext: { newArticles in
                                    articles = newArticles
                                    done()
                                }, onError: { error in
                                    done()
                                }).disposed(by: disposeBag)
                        }
                    }

                    it("returns articles") {
                        expect(articles.count).to(equal(10))
                    }
                }

                context("when articles request is failed") {
                    var apiError: ApiError?

                    beforeEach {
                        ArticleHttpMocker.scenario = ArticleHttpMocker.Scenario.fail

                        waitUntil(timeout: 10) { done in
                            service.findAllArticles(with: ArticlesRequest())
                                .subscribe(onNext: { newArticles in
                                    articles = newArticles
                                    done()
                                }, onError: { error in
                                    apiError = error as? ApiError
                                    done()
                                }).disposed(by: disposeBag)
                        }
                    }

                    it("returns api error client") {
                        expect(apiError).to(equal(ApiError.client))
                    }

                    it("returns empty articles") {
                        expect(articles.count).to(equal(0))
                    }
                }
            }
        }
    }

}
