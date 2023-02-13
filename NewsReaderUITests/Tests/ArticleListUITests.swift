import Ambassador
import XCTest

final class ArticleListUITests: XCTestCase {
    // MARK: - Private properties

    private var server: StubServer!
    private var app: XCUIApplication!

    // MARK: - Lifecycle

    override func setUpWithError() throws {
        try super.setUpWithError()

        continueAfterFailure = false

        server = try .init()
        try server.start()

        app = .init()
        app.launchArguments += ["-baseURL", "http://localhost:8080"]
    }

    override func tearDown() {
        server.stop()
        server = nil
        app = nil

        super.tearDown()
    }

    func test_success() throws {
        // Given success API response
        server.router["/1/coding_test/13ZZQX/full"] = try DataResponse("article-list-success.json")
        server.router["/image.jpg"] = try DataResponse("image.jpg")

        // When app is launched
        app.launch()

        // Then it lands on Article List screen with contents
        XCTAssert(app.staticTexts["News Reader"].exists)

        XCTAssert(app.staticTexts["How JB Hi-Fi and IAG show the squeeze on consumers"].exists)
        let abstractOne = NSPredicate(format: "label CONTAINS[c] %@", "Slowing appliance sales and surging insurance premiums")
        XCTAssert(app.staticTexts.containing(abstractOne).count == 1)
        XCTAssert(app.staticTexts["James Thomson"].exists)

        XCTAssert(app.staticTexts["Andrew Bragg’s peculiar mortgage"].exists)
        let abstractTwo = NSPredicate(format: "label CONTAINS[c] %@", "It’s highly irregular for an Australian senator to")
        XCTAssert(app.staticTexts.containing(abstractTwo).count == 1)
        XCTAssert(app.staticTexts["Joe Aston"].exists)

        XCTAssert(app.staticTexts["China moves to wind back Aussie beef and timber trade sanctions"].exists)
        let abstractThree = NSPredicate(format: "label CONTAINS[c] %@", "Plans to draw back export restrictions in the two")
        XCTAssert(app.staticTexts.containing(abstractThree).count == 1)
        XCTAssert(app.staticTexts["Michael Smith"].exists)

        XCTAssert(app.staticTexts["Frustrated renters buy $3.8m terrace house"].exists)
        let abstractFour = NSPredicate(format: "label CONTAINS[c] %@", "Three children in their 20s couldn’t find anywhere")
        XCTAssert(app.staticTexts.containing(abstractFour).count == 1)
        XCTAssert(app.staticTexts["Michael Bleby"].exists)
    }

    func test_failure() {
        // When app is launched without stubbed API response
        app.launch()

        // Then it lands on Article List screen with an error
        XCTAssert(app.staticTexts["News Reader"].exists)

        XCTAssert(app.staticTexts["Error"].exists)
        XCTAssert(app.staticTexts["There was a problem getting the articles"].exists)
        XCTAssert(app.buttons["OK"].exists)
    }
}
