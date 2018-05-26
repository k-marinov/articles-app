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
        information.append(genres.map { $0 + " " }.reduce("Genre: ",+))
        information.append("\n")
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
