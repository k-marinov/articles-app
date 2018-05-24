import Foundation
import SwiftyJSON

protocol BaseResource: class {

    init(data: Data)

    init(json: JSON)

    func map(from json: JSON)

}
