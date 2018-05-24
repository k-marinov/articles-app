import OHHTTPStubs
import OHHTTPStubs.NSURLRequest_HTTPBodyTesting

@testable import Telegraph

class ArticleHttpMocker {

    enum Scenario {
        case success
        case fail
    }

    static var scenario: ArticleHttpMocker.Scenario!

    func setUpStubs() {
        stubHttpResponse()
        OHHTTPStubs.setEnabled(true)
    }

    func removeStubs() {
        OHHTTPStubs.setEnabled(false)
        OHHTTPStubs.removeAllStubs()
    }

    private func stubHttpResponse() {
        stub(condition: { request -> Bool in
            return self.isUrlRequestSuccess(with: request)
        }, response: { _ -> OHHTTPStubsResponse in
            return self.response()
        })
    }

    private func response() -> OHHTTPStubsResponse {
        if ArticleHttpMocker.scenario == ArticleHttpMocker.Scenario.success {
            return OHHTTPStubsResponse(
                fileAtPath: OHPathForFile("articles.json", type(of: self))!,
                statusCode: 200,
                headers: ["Content-Type": "application/json"])
        } else if ArticleHttpMocker.scenario == ArticleHttpMocker.Scenario.fail {
            return OHHTTPStubsResponse(
                fileAtPath: OHPathForFile("empty.json", type(of: self))!,
                statusCode: 404,
                headers: ["Content-Type": "application/json"])
        }
        return OHHTTPStubsResponse(
            fileAtPath: OHPathForFile("empty.json", type(of: self))!,
            statusCode: 500,
            headers: ["Content-Type": "application/json"])
    }

    private func isUrlRequestSuccess(with urlRequest: URLRequest) -> Bool {
        let url: String = urlRequest.url!.absoluteURL.absoluteString
        return url.hasSuffix("articles.json") 
    }

}
