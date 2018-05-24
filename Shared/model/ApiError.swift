import  Foundation

enum ApiError: Error {

    case network

    case server

    case contentNotModified

    case client

    case unknown

}
