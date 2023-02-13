@testable import NewsReader
import XCTest

final class ArticleListTileItemTests: XCTestCase {
    // MARK: - Tests

    func test_content() {
        // Given an article
        let article = Asset.mock()

        // When creating an item for the article
        let item = ArticleListTileItem(asset: article) {}

        // Then it has the content of the article
        XCTAssertEqual(item.imageURL, "url")
        XCTAssertEqual(item.headline, "headline")
        XCTAssertEqual(item.abstract, "theAbstract")
        XCTAssertEqual(item.author, "byLine")
    }

    func test_action() {
        // Given an item
        var actionCalled = false
        let item = ArticleListTileItem(asset: .mock()) { actionCalled = true }

        // When executing the item action
        item.action()

        // Then it calls the injected action
        XCTAssert(actionCalled)
    }
}
