import Foundation
import SwiftyJSON

class ArticleResource: BaseResource, TableViewItem {

    private(set) var id: Int!
    private(set) var websiteUrl: String!
    private(set) var headline: String!
    private(set) var description: String!
    private(set) var articleBody: String!
    private(set) var rating: Int!
    private(set) var pictureUrl: String!
    private(set) var videoUrl: String!
    private(set) var actors: [String] = [String]()
    private(set) var director: String!
    private(set) var genres: [String] = [String]()
    private(set) var synopsis: String!
    private(set) var releaseDate: Date?
    private(set) var duration: String!
    private(set) var publishedDate: Date?
    private(set) var author: AuthorResource!

    required init(json: JSON) {
        map(from: json)
    }

    private func map(from json: JSON) {
        id = json["id"].intValue
        websiteUrl = json["website-url"].stringValue
        headline = json["headline"].stringValue
        description = json["description"].stringValue
        articleBody = json["article-body"].stringValue
        rating = json["ratings"].intValue
        pictureUrl = json["picture-url"].stringValue
        videoUrl = json["video-url"].stringValue
        actors.append(contentsOf: json["actors"].arrayValue.compactMap { $0.stringValue } )

        director = json["director"].stringValue
        genres.append(contentsOf: json["genre"].arrayValue.compactMap { $0.stringValue } )

        synopsis = json["synopsis"].stringValue
        releaseDate = DateUtil.createDate(
            from: json["release-date"].stringValue,
            dateFormat: DateFormat.iso8601Date,
            timeZone: TimeZone.current)

        duration = json["duration"].stringValue

        publishedDate = DateUtil.createDate(
            from: json["published-date"].stringValue,
            dateFormat: DateFormat.dayMonthYearHourMinute,
            timeZone: TimeZone.current)

        author = AuthorResource(json: json["author"])
    }

}
