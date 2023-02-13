@testable import NewsReader
import XCTest

final class ArticleServiceTests: XCTestCase {
    // MARK: - Private properties

    private var service: ArticleServiceProtocol!
    private var mockNetworkManager: MockNetworkManager!
    private var mockAppSettings: MockAppSettings!

    // MARK: - Lifecycle

    override func setUp() {
        super.setUp()

        mockNetworkManager = .init()
        mockAppSettings = .init()
        service = ArticleService(networkManager: mockNetworkManager, appSettings: mockAppSettings)
    }

    override func tearDown() {
        service = nil
        mockNetworkManager = nil
        mockAppSettings = nil

        super.tearDown()
    }
}

// MARK: - Tests

extension ArticleServiceTests {
    func test_getArticleList_receivedValues() {
        // When getting the article list
        service.getArticleList { _ in }

        // Then a network manager request is made
        XCTAssertEqual(mockNetworkManager.requestCallsCount, 1)
        XCTAssertEqual(
            mockNetworkManager.requestReceivedURL, "https://base.url/1/coding_test/13ZZQX/full"
        )
    }

    func test_getArticleList_success() {
        // Given network manager success
        let articleList = ArticleList.mock()
        mockNetworkManager.requestCompletionValue = articleList
        var result: Result<ArticleList, NetworkRequestError>?

        // When getting the article list
        service.getArticleList { result = $0 }

        // Then the response article list is returned
        XCTAssertEqual(result?.value, articleList)
    }

    func test_getArticleList_failure() {
        // Given network manager failure
        mockNetworkManager.requestCompletionValue = nil
        var result: Result<ArticleList, NetworkRequestError>?

        // When getting the article list
        service.getArticleList { result = $0 }

        // Then an error is returned
        XCTAssertEqual(result?.error, .network)
    }
}
