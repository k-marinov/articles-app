import Quick
import Nimble
import SwiftyJSON

@testable import Telegraph

class ArticlesResourceSpec: QuickSpec {

    override func spec() {
        describe("CourierNotificationsResource") {
            var resource: ArticlesResource!
            let validJsonData: Data = ArticleMother.createArticlesJsonData()

            describe("initializer") {
                describe("data argument") {
                    context("when has valid json data argument provided") {
                        beforeEach {
                            resource = ArticlesResource(data: validJsonData)
                        }

                        it("returns mapped articles") {
                            expect(resource.articles.count).to(equal(10))
                        }
                    }

                    context("when has empty json data argument provided") {
                        beforeEach {
                            resource = ArticlesResource(data: Data())
                        }

                        it("returns empty notifications array") {
                            expect(resource.articles).to(beEmpty())
                        }
                    }
                }
            }
        }
    }

}
