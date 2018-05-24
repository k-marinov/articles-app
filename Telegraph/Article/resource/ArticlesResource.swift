import Foundation
import SwiftyJSON

class ArticlesResource: BaseResource {

    private(set) var articles: [ArticleResource] = [ArticleResource]()

    required init(data: Data) {
        map(from: JSON(data))
    }

    private func map(from json: JSON) {
        let newArticles: [ArticleResource] = json["collection"].arrayValue.compactMap { ArticleResource(json: $0) }
        articles.append(contentsOf: newArticles)
    }

}
