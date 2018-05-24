import Foundation
import SwiftyJSON

protocol BaseResource: class {

    init(data: Data)

}

extension BaseResource {

    init(data: Data) {
        fatalError("override required")
    }

}
