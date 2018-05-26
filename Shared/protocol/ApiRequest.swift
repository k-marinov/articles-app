import Foundation
import RxSwift

protocol ApiRequest {

    typealias HeaderName = String

    typealias HeaderValue = String

    func httpRequestUrl() -> String

    func httpMethod() -> HttpMethod

    func httpRequestBody() -> Data?

    func headers() -> Dictionary<HeaderName, HeaderValue>?

    func httpParameters() -> [String: Any]?

    func asURLRequest() throws -> URLRequest

    func response(from newResponse: HttpResponse) -> ApiResponse

    func response(from newResponse: HttpResponse) -> Observable<ApiResponse>

}

extension ApiRequest {

    func asURLRequest() throws -> URLRequest {
        return createUrlRequest(withUrl: try createUrl())
    }

    func response(from newResponse: HttpResponse) -> Observable<ApiResponse> {
        return Observable<ApiResponse>.create { observer  in
            if newResponse.error == nil {
                let apiResponse: ApiResponse = self.response(from: newResponse)
                if apiResponse.isSuccess() {
                    observer.onNext(apiResponse)
                    observer.onCompleted()
                } else {
                    observer.onError(apiResponse.apiFailError())
                }
            } else {
                observer.onError(ApiError.network)
            }
            return Disposables.create()
        }
    }

    private func createUrl() throws -> URL {
        let url: URL? = URL(string: httpRequestUrl())
        if url == nil {
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
        headers()?.forEach { header in
            urlRequest.addValue(header.1, forHTTPHeaderField: header.0)
        }
    }

}
