import Ambassador
import Foundation

enum DataResponseError: Error {
    case fileNotFound
}

extension DataResponse {
    /// Loads a file from the bundle to use as a data response.
    init(_ name: String, contentType: String = "application/octet-stream") throws {
        guard let url = Bundle(for: StubServer.self).url(forResource: name, withExtension: nil) else {
            throw DataResponseError.fileNotFound
        }
        let data = try Data(contentsOf: url)
        self.init(contentType: contentType) { _ in data }
    }
}
