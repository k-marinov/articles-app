import XCGLogger

class Logger {

    static var log: XCGLogger {
        let log = XCGLogger.default
        log.setup(
            level: Logger.logLevel,
            showLogIdentifier: false,
            showFunctionName: false,
            showThreadName: true,
            showLevel: true,
            showFileNames: true,
            showLineNumbers: false,
            showDate: true)
        return log
    }

    private static var logLevel: XCGLogger.Level {
        #if DEBUG
        return XCGLogger.Level.debug
        #else
        return XCGLogger.Level.info
        #endif
    }

}
