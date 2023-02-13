@testable import NewsReader

final class MockUserDefaults: UserDefaultsProtocol {
    var stringReturnValues: [String: String] = [:]

    func string(forKey defaultName: String) -> String? {
        stringReturnValues[defaultName]
    }
}
