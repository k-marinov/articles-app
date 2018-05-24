import Foundation

class ApiResponse {

    private(set) var resource: BaseResource?
    private(set) var httpStatusCode: HttpStatusCode!
    private(set) var successHttpStatusCode: HttpStatusCode!

    init<RESOURCE: BaseResource>(
        resourceType: RESOURCE.Type,
        httpResponse: HttpResponse,
        successHttpStatusCode: HttpStatusCode) {
        self.resource = createResource(resourceType: resourceType, data: httpResponse.data)
        self.httpStatusCode = HttpStatusCode.findOrReturnUndefined(statusCode: httpResponse.response?.statusCode)
        self.successHttpStatusCode = successHttpStatusCode

    }

    func createApiErrorOnFail(with apiRequest: ApiRequest) -> ApiError {
        if hasClientError() {
            return ApiError.client
        } else if hasServerError() {
            return ApiError.server
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
