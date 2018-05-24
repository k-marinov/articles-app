import Foundation
import Quick
import Nimble
import SwiftyJSON

@testable import Telegraph

class ArticleResourceSpec: QuickSpec {

    override func spec() {
        describe("CourierNotificationsResource") {
            var resource: ArticleResource!
            let validJson: JSON = ArticleMother.createArticleJson()
            let releaseDate: Date = DateUtil.createDate(
                from: "15-01-2015",
                dateFormat: DateFormat.iso8601Date,
                timeZone: TimeZone.current)!
            let publishedDate: Date = DateUtil.createDate(
                from: "14 January 2016 • 12:00pm",
                dateFormat: DateFormat.dayMonthYearHourMinute,
                timeZone: TimeZone.current)!
            let actors: [String] = ["Leonardo DiCaprio", "Tom Hardy", "Domhnall Gleeson", "Will Poulter"]
            let genres: [String] = ["Action", "Drama"]
            let synopsis: String = "In the 1820s, a frontiersman, Hugh Glass, sets out on a"
                + " path of vengeance against those who left him for dead after a bear mauling"

            describe("initializer") {
                describe("json argument") {
                    context("when has valid json argument provided") {
                        beforeEach {
                            resource = ArticleResource(json: validJson)
                        }

                        it("returns mapped article") {
                            expect(resource.id).to(equal(1))
                            expect(resource.websiteUrl).to(equal("http://www.telegraph.co.uk/film/the-revenant/"))
                            expect(resource.headline).to(equal("The revenant"))
                            expect(resource.description).to(equal("Leo's beautiful endurance test"))
                            expect(resource.articleBody).to(equal(""))
                            expect(resource.rating).to(equal(4))
                            expect(resource.pictureUrl).to(equal("http://www.telegraph.co.uk/content/"
                                + "dam/film/the revenant/leo-xlarge.jpg"))

                            expect(resource.videoUrl).to(equal(""))
                            expect(resource.actors.count).to(equal(4))
                            expect(resource.actors).to(equal(actors))

                            expect(resource.director).to(equal("Alejandro G. Iñárritu"))
                            expect(resource.genres.count).to(equal(2))
                            expect(resource.genres).to(equal(genres))

                            expect(resource.synopsis).to(equal(synopsis))
                            expect(resource.releaseDate).to(equal(releaseDate))
                            expect(resource.duration).to(equal("156 mins"))
                            expect(resource.publishedDate).to(equal(publishedDate))
                            expect(resource.author).notTo(beNil())
                        }

                    }

                    context("when has empty json data argument provided") {
                        beforeEach {
                            resource = ArticleResource(json: JSON(Data()))
                        }

                        it("returns mapped article with default values") {
                            expect(resource.id).to(equal(0))
                            expect(resource.websiteUrl).to(beEmpty())
                            expect(resource.headline).to(beEmpty())
                            expect(resource.description).to(beEmpty())
                            expect(resource.articleBody).to(beEmpty())
                            expect(resource.rating).to(equal(0))
                            expect(resource.pictureUrl).to(beEmpty())

                            expect(resource.videoUrl).to(beEmpty())
                            expect(resource.actors.count).to(equal(0))
                            expect(resource.actors).to(equal([]))

                            expect(resource.director).to(beEmpty())
                            expect(resource.genres.count).to(equal(0))
                            expect(resource.genres).to(equal([]))

                            expect(resource.synopsis).to(beEmpty())
                            expect(resource.releaseDate).to(beNil())
                            expect(resource.duration).to(beEmpty())
                            expect(resource.publishedDate).to(beNil())
                            expect(resource.author).notTo(beNil())
                        }
                    }
                }
            }
        }
    }

}
