class StringUtil {

    class func isNilOrEmpty(_ string: String?) -> Bool {
        switch string {
        case .some(let nonNilString):
            return nonNilString.isEmpty
        default:
            return true
        }
    }

    class func concat(values: String...) -> String {
        var newString: String = ""
        for value in values {
            newString.append(value)
        }
        return newString
    }

}
