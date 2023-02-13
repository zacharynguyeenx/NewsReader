@testable import NewsReader
import XCTest

final class NetworkManagerTests: XCTestCase {
    // MARK: - Private properties

    private var manager: NetworkManagerProtocol!
    private var mockSession: MockURLSession!

    // MARK: - Lifecycle

    override func setUp() {
        super.setUp()

        mockSession = .init()
        manager = NetworkManager(session: mockSession)
    }

    override func tearDown() {
        mockSession = nil
        manager = nil

        super.tearDown()
    }
}

// MARK: - Tests

extension NetworkManagerTests {
    func test_request_receivedValues() {
        // Given request data
        let url = "https://www.google.com"

        // When making a request
        manager.request(String.self, url: url) { _ in }

        // Then the URL session receives values for a data task
        XCTAssertEqual(mockSession.dataTaskCallsCount, 1)
        XCTAssertEqual(mockSession.dataTaskReceivedURL?.absoluteString, url)
        XCTAssertNotNil(mockSession.dataTaskReceivedCompletionHandler)
        XCTAssertEqual(mockSession.dataTaskReturnValue.resumeCallsCount, 1)
    }

    func test_request_success() {
        // Given success response raw data
        let data = try! JSONEncoder().encode("response")
        var result: Result<String, NetworkRequestError>?
        let expectation = expectation(description: #function)

        // When making the request
        manager.request(String.self, url: "https://www.google.com") {
            result = $0
            expectation.fulfill()
        }
        mockSession.dataTaskReceivedCompletionHandler?(data, .init(), nil)

        // Then the decoded response data is returned
        waitForExpectations(timeout: 1)
        XCTAssertEqual(result?.value, "response")
    }

    func test_request_failure_badURL() {
        // Given bad request URL
        let url = ""
        var result: Result<String, NetworkRequestError>?
        let expectation = expectation(description: #function)

        // When making the request
        manager.request(String.self, url: url) {
            result = $0
            expectation.fulfill()
        }

        // Then a badURL error is returned
        waitForExpectations(timeout: 1)
        XCTAssertEqual(result?.error, .badURL)
    }

    func test_request_failure_networkError() {
        // Given failure response data
        let error = NSError()
        var result: Result<String, NetworkRequestError>?
        let expectation = expectation(description: #function)

        // When making the request
        manager.request(String.self, url: "https://www.google.com") {
            result = $0
            expectation.fulfill()
        }
        mockSession.dataTaskReceivedCompletionHandler?(nil, .init(), error)

        // Then a network error is returned
        waitForExpectations(timeout: 1)
        XCTAssertEqual(result?.error, .network)
    }

    func test_request_failure_jsonDecoding() {
        // Given un-decodable response data
        let data = Data()
        var result: Result<String, NetworkRequestError>?
        let expectation = expectation(description: #function)

        // When making the request
        manager.request(String.self, url: "https://www.google.com") {
            result = $0
            expectation.fulfill()
        }
        mockSession.dataTaskReceivedCompletionHandler?(data, .init(), nil)

        // Then a jsonDecoding error is returned
        waitForExpectations(timeout: 1)
        XCTAssertEqual(result?.error, .jsonDecoding)
    }
}
