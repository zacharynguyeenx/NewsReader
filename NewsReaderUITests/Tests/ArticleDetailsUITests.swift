import Ambassador
import XCTest

final class ArticleDetailsUITests: XCTestCase {
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

    func test() throws {
        // Given the app is on Article List screen
        server.router["/1/coding_test/13ZZQX/full"] = try DataResponse("article-list-success.json")
        server.router["/image.jpg"] = try DataResponse("image.jpg")
        server.router["/article.html"] = try DataResponse("article.html", contentType: "text/html")
        app.launch()

        // When tapping on an article
        app.collectionViews.cells.firstMatch.tap()

        // Then it navigates to Article Details screen with the article web page loaded
        XCTAssert(app.staticTexts["Hello world!"].exists)
    }
}
