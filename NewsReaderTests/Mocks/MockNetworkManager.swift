@testable import NewsReader

final class MockNetworkManager: NetworkManagerProtocol {
    private(set) var requestCallsCount = 0
    private(set) var requestReceivedURL: String?
    var requestCompletionValue: Any?

    func request<Response>(
        _: Response.Type, url urlString: String, completion: @escaping (Result<Response, NetworkRequestError>) -> Void
    ) where Response: Decodable {
        requestCallsCount += 1
        requestReceivedURL = urlString

        guard let requestCompletionValue else { return completion(.failure(.network)) }
        return completion(.success(requestCompletionValue as! Response))
    }
}
