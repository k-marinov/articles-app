import Foundation

class DateUtil {

    class func dateFormatter(with dateFormat: DateFormat, timeZone: TimeZone) -> DateFormatter {
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = dateFormat.rawValue
        dateFormatter.timeZone = timeZone
        return dateFormatter
    }

    class func createDate(fromDateString dateString: String?, dateFormat: DateFormat, timeZone: TimeZone) -> Date? {
        if !StringUtil.isNilOrEmpty(dateString) {
            return dateFormatter(with: dateFormat, timeZone: timeZone).date(from: dateString!)
        }
        return nil
    }

}
