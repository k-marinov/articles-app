import Foundation

@testable import Telegraph

class HttpResponseMother {

    class func createHttpResponse(withStatusCode statusCode: Int) -> HttpResponse {
        let response: HTTPURLResponse? = HTTPURLResponse(
            url: URL(string: "http://telegraph.co.uk")!,
            statusCode: statusCode,
            httpVersion: "1.0",
            headerFields: nil)
        let value: Data = "{}".data(using: String.Encoding.utf8)!
        return HttpResponse(response: response, data: value, error: NSError(domain: "", code: 0, userInfo: nil))
    }

    class func createEmptyHttpResponse(withStatusCode statusCode: Int) -> HttpResponse {
        let response: HTTPURLResponse? = HTTPURLResponse(
            url: URL(string: "http://telegraph.co.uk")!,
            statusCode: statusCode,
            httpVersion: "1.0",
            headerFields: nil)
        let value: Data = "".data(using: String.Encoding.utf8)!
        return HttpResponse(response: response, data: value, error: NSError(domain: "", code: 0, userInfo: nil))
    }

}
