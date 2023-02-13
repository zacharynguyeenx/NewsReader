import Foundation

protocol UserDefaultsProtocol {
    func string(forKey defaultName: String) -> String?
}

extension UserDefaults: UserDefaultsProtocol {}
