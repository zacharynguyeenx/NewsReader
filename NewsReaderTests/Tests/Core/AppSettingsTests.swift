@testable import NewsReader
import XCTest

final class AppSettingsTests: XCTestCase {
    // MARK: - Private properties

    private var appSettings: AppSettingsProtocol!
    private var mockUserDefaults: MockUserDefaults!

    // MARK: - Lifecycle

    override func setUp() {
        super.setUp()

        mockUserDefaults = .init()
        appSettings = AppSettings(userDefaults: mockUserDefaults)
    }

    override func tearDown() {
        mockUserDefaults = nil
        appSettings = nil

        super.tearDown()
    }
}

// MARK: - Tests

extension AppSettingsTests {
    func test_baseURL_available() {
        // Given baseURL is available from the user defaults
        mockUserDefaults.stringReturnValues["baseURL"] = "https://base.url"

        // When getting the baseURL
        let baseURL = appSettings.baseURL

        // Then the baseURL is coming from the user defaults
        XCTAssertEqual(baseURL, "https://base.url")
    }

    func test_baseURL_default() {
        // Given baseURL is not available from the user defaults
        mockUserDefaults.stringReturnValues = [:]

        // When getting the baseURL
        let baseURL = appSettings.baseURL

        // Then the default baseURL is returned
        XCTAssertEqual(baseURL, "https://bruce-v2-mob.fairfaxmedia.com.au")
    }
}
