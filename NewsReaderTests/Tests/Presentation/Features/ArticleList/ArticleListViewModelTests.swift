@testable import NewsReader
import XCTest

final class ArticleListViewModelTests: XCTestCase {
    // MARK: - Private properties

    private var viewModel: ArticleListViewModel!
    private var mockArticleService: MockArticleService!

    // MARK: - Lifecycle

    override func setUp() {
        super.setUp()

        mockArticleService = .init()
        viewModel = .init(articleService: mockArticleService)
    }

    override func tearDown() {
        viewModel = nil
        mockArticleService = nil

        super.tearDown()
    }
}

// MARK: - Tests

extension ArticleListViewModelTests {
    func test_getProductList_receivedValues() {
        // When getting the articles
        viewModel.getArticles {}

        // Then an article list request is made
        XCTAssertEqual(mockArticleService.getArticleListCallsCount, 1)
        XCTAssertNotNil(mockArticleService.getArticleListReceivedCompletion)
    }

    func test_getProductList_success() {
        // Given article service success response
        let articleList: [Asset] = [.mock(headline: "1", timeStamp: 1), .mock(headline: "2", timeStamp: 2)]
        var items: [ArticleListTileItem]?
        viewModel.itemsCallback = { items = $0 }
        var getArticlesCompleted = false

        // When getting the articles
        viewModel.getArticles { getArticlesCompleted = true }
        mockArticleService.getArticleListReceivedCompletion?(.success(.mock(assets: articleList)))

        // Then the sorted item list is returned
        XCTAssert(getArticlesCompleted)
        XCTAssertEqual(items?.map(\.headline), ["2", "1"])
    }

    func test_getProductList_failure() {
        // Given article service failure response
        let error = NetworkRequestError.network
        var showNetworkErrorCalled = false
        viewModel.showNetworkErrorCallback = { showNetworkErrorCalled = true }
        var getArticlesCompleted = false

        // When
        viewModel.getArticles { getArticlesCompleted = true }
        mockArticleService.getArticleListReceivedCompletion?(.failure(error))

        // Then
        XCTAssert(getArticlesCompleted)
        XCTAssert(showNetworkErrorCalled)
    }
}
