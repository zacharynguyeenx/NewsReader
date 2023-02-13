import Foundation

extension Result {
    /// The wrapped value if this result is success.
    var value: Success? {
        guard case let .success(value) = self else {
            return nil
        }
        return value
    }

    /// The wrapped error if this result is failure.
    var error: Failure? {
        guard case let .failure(error) = self else {
            return nil
        }
        return error
    }
}
