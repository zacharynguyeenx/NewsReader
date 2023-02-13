import Foundation

protocol NetworkManagerProtocol {
    /// Requests a JSON decodable response with the given URL.
    func request<Response>(
        _ type: Response.Type,
        url urlString: String,
        completion: @escaping (Result<Response, NetworkRequestError>) -> Void
    ) where Response: Decodable
}

struct NetworkManager: NetworkManagerProtocol {
    // MARK: - Private properties

    private let session: any URLSessionProtocol

    // MARK: - Initialisers

    init(session: any URLSessionProtocol = URLSession.shared) {
        self.session = session
    }

    // MARK: - NetworkManagerProtocol

    func request<Response>(
        _: Response.Type,
        url urlString: String,
        completion: @escaping (Result<Response, NetworkRequestError>) -> Void
    ) where Response: Decodable {
        guard let url = URL(string: urlString) else {
            return completion(.failure(.badURL))
        }
        session.dataTask(with: url) { data, _, _ in
            DispatchQueue.main.async {
                guard let data else {
                    return completion(.failure(.network))
                }
                guard let response = try? JSONDecoder().decode(Response.self, from: data) else {
                    return completion(.failure(.jsonDecoding))
                }
                return completion(.success(response))
            }
        }
        .resume()
    }
}

// MARK: - Models

enum NetworkRequestError: Error, Equatable {
    case badURL
    case jsonDecoding
    case network
}
