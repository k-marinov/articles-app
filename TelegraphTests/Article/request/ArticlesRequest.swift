import Quick
import Nimble

@testable import Telegraph

class ArticlesRequestSpec: QuickSpec {

    override func spec() {
        describe("ArticlesRequest") {
            let request: ArticlesRequest = ArticlesRequest()

            describe("initializer") {
                context("when initalized") {

                    it("returns nil") {
                        expect(request.headers()).to(beNil())
                    }

                    it("returns nil") {
                        expect(request.httpRequestBody()).to(beNil())
                    }

                    it("returns nil") {
                        expect(request.httpParameters()).to(beNil())
                    }

                    it("returns http method") {
                        expect(request.httpMethod()).to(equal(HttpMethod.get))
                    }

                    it("returns request url") {
                        expect(request.httpRequestUrl()).to(equal("https://s.telegraph.co.uk/tmgmobilepub/articles.json"))
                    }
                }
            }

            describe("createApiResponse") {
                var apiResponse: ApiResponse!

                context("when status code is 200") {
                    beforeEach {
                        let httpResponse = HttpResponseMother.createHttpResponse(withStatusCode: 200)
                        apiResponse = request.createApiResponse(httpResponse: httpResponse)
                    }

                    it("returns success") {
                        expect(apiResponse.isSuccess()).to(beTrue())
                    }

                    it("returns resource type") {
                        expect(apiResponse.resource).to(beAKindOf(ArticlesResource.self))
                    }

                    it("returns resource") {
                        expect(apiResponse.resource).notTo(beNil())
                    }
                }

                context("when status code is 404") {
                    beforeEach {
                        let httpResponse = HttpResponseMother.createEmptyHttpResponse(withStatusCode: 404)
                        apiResponse = request.createApiResponse(httpResponse: httpResponse)
                    }

                    it("returns success") {
                        expect(apiResponse.isSuccess()).to(beFalse())
                    }

                    it("returns nil resource") {
                        expect(apiResponse.resource).to(beNil())
                    }
                }
            }
        }
    }

}
