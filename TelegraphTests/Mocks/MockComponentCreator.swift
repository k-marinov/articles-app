@testable import Telegraph

class MockComponentCreator: ComponentCreatable {

    var articleService: ArticleService!

    init() {
    }

    func mockArticleService() -> MockArticleService {
        return articleService as! MockArticleService
    }

    func create(with componentCreatable: ComponentCreatable) -> ArticleService {
        return articleService
    }

    class func buildAllMocks() -> MockComponentCreator {
        let creator: MockComponentCreator = MockComponentCreator()
        creator.articleService = MockArticleService(componentCreatable: creator)
        return creator
    }

}
