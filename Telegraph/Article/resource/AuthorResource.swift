import Foundation
import SwiftyJSON

class AuthorResource: BaseResource {

    private(set) var name: String!
    private(set) var imageUrl: String!
    private(set) var twitter: String!

    required init(json: JSON) {
        map(from: json)
    }

    private func map(from json: JSON) {
        name = json["name"].stringValue
        imageUrl = json["headshot"].stringValue
        twitter = json["twitter"].stringValue
    }

}
