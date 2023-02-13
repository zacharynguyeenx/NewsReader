import Foundation
@testable import NewsReader

final class MockURLSession: URLSessionProtocol {
    private(set) var dataTaskCallsCount = 0
    private(set) var dataTaskReceivedURL: URL?
    private(set) var dataTaskReceivedCompletionHandler: ((Data?, URLResponse?, Error?) -> Void)?
    var dataTaskReturnValue = MockURLSessionDataTask()

    func dataTask(
        with url: URL, completionHandler: @escaping @Sendable (Data?, URLResponse?, Error?) -> Void
    ) -> URLSessionDataTaskProtocol {
        dataTaskCallsCount += 1
        dataTaskReceivedURL = url
        dataTaskReceivedCompletionHandler = completionHandler
        return dataTaskReturnValue
    }
}

final class MockURLSessionDataTask: URLSessionDataTaskProtocol {
    private(set) var resumeCallsCount = 0

    func resume() {
        resumeCallsCount += 1
    }
}
