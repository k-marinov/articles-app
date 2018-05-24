import Quick
import Nimble
import RxSwift

@testable import Telegraph

class ArticlesViewModelSpec: QuickSpec {

    var date: Date = Date()

    override func spec() {

        describe("ArticlesViewModel") {
            let disposeBag: DisposeBag = DisposeBag()
            let creator: MockComponentCreator = MockComponentCreator.buildAllMocks()
            var viewModel: ArticlesViewModel!
            var beginRefreshingCollector: RxCollector<Bool>!
            var reloadTableViewCollector: RxCollector<Void>!


            describe("findAllArticles") {
                beforeEach {
                    viewModel = ArticlesViewModel(componentCreatable: creator)
                    beginRefreshingCollector = RxCollector<Bool>()
                        .collect(from: viewModel.beginRefreshing.asObservable())
                    reloadTableViewCollector = RxCollector<Void>()
                        .collect(from: viewModel.reloadTableView.asObservable())
                }

                context("when request is success") {
                    beforeEach {
                        creator.mockArticleService().isRequestSuccess = true
                        waitUntil(timeout: 10.0, action: { done in
                            viewModel.findAllArticles()
                                .subscribe(onError: { _ in
                                    done()
                                }, onCompleted: {
                                    done()
                                }).disposed(by: disposeBag)
                        })
                    }

                    it("starts and stops refresh control") {
                        expect(beginRefreshingCollector.results).to(equal([true, false]))
                    }

                    it("reloads table view") {
                        expect(reloadTableViewCollector.results.count).to(equal(1))
                    }
                }

                context("when request is success") {
                    beforeEach {
                        creator.mockArticleService().isRequestSuccess = false
                        waitUntil(timeout: 10.0, action: { done in
                             viewModel.findAllArticles()
                                .subscribe(onError: { _ in
                                    done()
                                }, onCompleted: {
                                    done()
                                }).disposed(by: disposeBag)
                        })
                    }

                    it("starts and stops refresh control") {
                        expect(beginRefreshingCollector.results).to(equal([true, false]))
                    }

                    it("does not reloads table view") {
                        expect(reloadTableViewCollector.results.count).to(equal(0))
                    }
                }
            }
        }
    }

}
