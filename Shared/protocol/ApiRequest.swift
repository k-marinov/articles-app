import Foundation

protocol ApiRequest {

    typealias HeaderName = String

    typealias HeaderValue = String

    func httpRequestUrl() -> String

    func httpMethod() -> HttpMethod

    func httpRequestBody() -> Data?

    func headers() -> Dictionary<HeaderName, HeaderValue>

    func httpParameters() -> [String: Any]?

    func asURLRequest() throws -> URLRequest

    func createApiResponse(httpResponse: HttpResponse) -> ApiResponse

}

extension ApiRequest {

    func asURLRequest() throws -> URLRequest {
        return createUrlRequest(withUrl: try createUrl())
    }

    private func createUrl() throws -> URL {
        let url: URL? = URL(string: httpRequestUrl())
        if url == nil {
            Logger.log.debug("cannot create url with httpRequestUrl=\(httpRequestUrl())")
            throw ClassError.invalidArgument
        }
        return url!
    }

    private func createUrlRequest(withUrl url: URL) -> URLRequest {
        var urlRequest: URLRequest = URLRequest(url: url)
        urlRequest.cachePolicy = URLRequest.CachePolicy.reloadIgnoringLocalCacheData
        urlRequest.timeoutInterval = 30.0
        urlRequest.httpMethod = httpMethod().rawValue
        setHttpBodyIfRequired(toUrlRequest: &urlRequest)
        appendHttpHeaders(toUrlRequest: &urlRequest)
        return urlRequest
    }

    private func setHttpBodyIfRequired(toUrlRequest  urlRequest: inout URLRequest) {
        if let httpRequestBody: Data = httpRequestBody() {
            urlRequest.httpBody = httpRequestBody
        }
    }

    private func appendHttpHeaders(toUrlRequest  urlRequest: inout URLRequest) {
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        headers().forEach { header in
            urlRequest.addValue(header.1, forHTTPHeaderField: header.0)
        }
    }

}
