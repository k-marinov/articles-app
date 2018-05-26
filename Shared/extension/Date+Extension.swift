import Foundation

extension Date {

    func toDateString(with format: DateFormat, timeZone: TimeZone) -> String {
        return DateUtil.dateFormatter(with: format, timeZone: timeZone).string(from: self)
    }

}
