import Foundation

class ArticlesRequest: ApiRequest {

    func httpMethod() -> HttpMethod {
        return HttpMethod.get
    }

    func httpRequestUrl() -> String {
        return "https://s.telegraph.co.uk/tmgmobilepub/articles.json"
    }

    func httpRequestBody() -> Data? {
        return nil
    }

    func httpParameters() -> [String : Any]? {
        return nil
    }

    func headers() -> Dictionary<HeaderName, HeaderValue> {
        return [:]
    }

    func createApiResponse(httpResponse: HttpResponse) -> ApiResponse {
        return ApiResponse(httpResponse: httpResponse, successHttpStatusCode: HttpStatusCode.created)
    }

}
