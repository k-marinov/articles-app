import Foundation
import SwiftyJSON

@testable import Telegraph

class ArticleMother {

    class func createArticles() -> ArticlesResource {
        return ArticlesResource(data: createArticlesJsonData())
    }

    class func createArticlesJsonData() -> Data {
        return FileHelper().createData(fromFilename: "articles", ofType: "json")!
    }

    class func createArticle() -> ArticleResource {
        return ArticleResource(json: createArticleJson())
    }

    class func createArticleJson() -> JSON {
        return try! JSON(data: FileHelper().createData(fromFilename: "article", ofType: "json")!)
    }

}
