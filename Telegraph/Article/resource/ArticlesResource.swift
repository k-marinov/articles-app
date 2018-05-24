import Foundation
import SwiftyJSON

class ArticlesResource: BaseResource {
    
    required init(data: Data) {
        map(from: JSON(data))
    }

    func map(from json: JSON) {
    }

}
