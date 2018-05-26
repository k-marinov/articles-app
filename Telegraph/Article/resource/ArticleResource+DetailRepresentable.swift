import Foundation

extension ArticleResource {

    func castAndCrew() -> String {
        var castAndCrew: String = ""
        castAndCrew.append(actors.map { $0 + "\n" }.reduce("Actors: ",+))
        castAndCrew.append("\n")
        castAndCrew.append("Director: " + director!)
        return castAndCrew
    }

    func information() -> String {

        var information: String = ""
        information.append(genres.map { $0 + "\n" }.reduce("Genre: ",+))
        information.append("Duration: " + duration)
        information.append("\n")
        information.append(releaseDateFormatted())
        information.append("\n")
        information.append("\n")
        information.append("Author: " + author.name)
        information.append("\n")
        information.append("Twitter: " + author.twitter)
        information.append("\n")
        information.append(publishedDateFormatted())
        return information

    }

    private func releaseDateFormatted() -> String {
        let date: String? = releaseDate?.toDateString(
            with: DateFormat.dayMonthYear, timeZone: TimeZone.current)
        if let newDate = date {
            return "Release date: " + newDate
        }
        return ""
    }

    private func publishedDateFormatted() -> String {
        let date: String? = publishedDate?.toDateString(
            with: DateFormat.dayMonthYear, timeZone: TimeZone.current)
        if let newDate = date {
            return "Publish date: " + newDate
        }
        return ""
    }

}


//{
//    "id": 3,
//    "website-url": "http://www.telegraph.co.uk/film/room/",
//    "headline": "Room",
//    "description": "Brie Larson is impeccable",
//    "article-body": "",
//    "ratings": 3,
//    "picture-url": "http://www.telegraph.co.uk/content/dam/film/Room/room1-xlarge.jpg",
//    "video-url": "",
//    "actors": [
//    "Brie Larson",
//    "Jacob Tremblay",
//    "Joan Allen",
//    "Sean Bridgers",
//    "Tom McCamus",
//    "William H. Macy"
//    ],
//    "director": "Lenny Abrahamson",
//    "genre": [
//    "Drama"
//    ],
//    "synopsis": "A mother forced to raise her child in a single room in an adaptation of the best-selling novel by Emma Donoghue",
//    "release-date": "29-01-2015",
//    "duration": "118 mins",
//    "published-date": "14 January 2016 • 5:15pm",
//    "author": {
//        "name": "Tim Robey",
//        "headshot": "http://www.telegraph.co.uk/content/dam/film/team/tim-robey-small.jpg",
//        "twitter": "@trim_obey"
//    }
//},
