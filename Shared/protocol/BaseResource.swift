import Foundation
import SwiftyJSON

protocol BaseResource: class {

    init(data: Data)

    func map(from json: JSON)

}
