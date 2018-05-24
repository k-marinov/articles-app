import Foundation
import RxSwift

class ApiClient {

    private let httpClient: HttpClient = HttpClient()

    func request(with apiRequest: ApiRequest) -> Observable<ApiResponse> {
        return httpClient.request(urlRequest: try! apiRequest.asURLRequest()).flatMap { httpResponse in
            return Observable<ApiResponse>.create { observer  in
                if httpResponse.error == nil {
                    let apiResponse: ApiResponse = apiRequest.createApiResponse(httpResponse: httpResponse)
                    if apiResponse.isSuccess() {
                        observer.onNext(apiResponse)
                        observer.onCompleted()
                    } else {
                        let apiError: ApiError = apiResponse.createApiErrorOnFail(with: apiRequest)
                        observer.onError(apiError)
                    }
                } else {
                    observer.onError(ApiError.network)
                }
                return Disposables.create()
            }
        }
    }

}
