protocol ArticleDetailRepresentable {

    var pictureUrl: String! { get }

    var rating: Int! { get }

    var headline: String! { get }

    var description: String! { get }

    var synopsis: String! { get }

    func castAndCrew() -> String

    func information() -> String

    var author: AuthorResource! { get }

}
