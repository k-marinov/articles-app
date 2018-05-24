import Foundation

class HttpResponse {

    private(set) var response: HTTPURLResponse?
    private(set) var data: Data?
    private(set) var error: Error?

    init(response: HTTPURLResponse?, data: Data?, error: Error?) {
        self.response = response
        self.data = data
        self.error = error
    }

}
