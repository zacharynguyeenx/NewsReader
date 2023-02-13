@testable import NewsReader

final class MockArticleService: ArticleServiceProtocol {
    private(set) var getArticleListCallsCount = 0
    private(set) var getArticleListReceivedCompletion: ((Result<ArticleList, NetworkRequestError>) -> Void)?

    func getArticleList(completion: @escaping (Result<ArticleList, NetworkRequestError>) -> Void) {
        getArticleListCallsCount += 1
        getArticleListReceivedCompletion = completion
    }
}
