import Foundation

class ApiResponse {

    private(set) var resource: BaseResource?
    private(set) var httpStatusCode: HttpStatusCode!
    private(set) var successHttpStatusCode: HttpStatusCode!
    private(set) var headers: [AnyHashable: Any] = [AnyHashable: Any]()

    init<RESOURCE: BaseResource>(
        resourceType: RESOURCE.Type,
        httpResponse: HttpResponse,
        successHttpStatusCode: HttpStatusCode) {
        self.resource = createResource(resourceType: resourceType, data: httpResponse.data)
        self.httpStatusCode = HttpStatusCode.findOrReturnUndefined(statusCode: httpResponse.response?.statusCode)

        self.successHttpStatusCode = successHttpStatusCode
        if let headers =  httpResponse.response?.allHeaderFields {
            self.headers = headers
        }
    }

    init(httpResponse: HttpResponse, successHttpStatusCode: HttpStatusCode) {
        self.successHttpStatusCode = successHttpStatusCode
        self.httpStatusCode = HttpStatusCode.findOrReturnUndefined(statusCode: httpResponse.response?.statusCode)
        if let headers =  httpResponse.response?.allHeaderFields {
            self.headers = headers
        }
    }

    func createApiErrorOnFail(with apiRequest: ApiRequest) -> ApiError {
        if hasClientError() {
            return ApiError.client
        } else if hasServerError() {
            return ApiError.server
        } else if httpStatusCode == HttpStatusCode.notModified {
            return ApiError.contentNotModified
        }
        return ApiError.unknown
    }

    func isSuccess() -> Bool {
        return successHttpStatusCode == httpStatusCode
    }

    private func createResource<RESOURCE: BaseResource>(resourceType: RESOURCE.Type, data: Data?) -> BaseResource? {
        if hasData(withData: data) {
            return RESOURCE(data: data!)
        }
        return nil
    }

    private func hasData(withData data: Data?) -> Bool {
        if let data: Data = data, data.count > 0 {
            return true
        }
        return false
    }

    private func hasClientError() -> Bool {
        return HttpStatusCode.clientErrorsGroup.contains(httpStatusCode.rawValue)
    }

    private func hasServerError() -> Bool {
        return HttpStatusCode.serverErrorsGroup.contains(httpStatusCode.rawValue)
    }

}
