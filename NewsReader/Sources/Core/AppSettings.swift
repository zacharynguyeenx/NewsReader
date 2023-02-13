import Foundation

protocol AppSettingsProtocol {
    var baseURL: String { get }
}

struct AppSettings: AppSettingsProtocol {
    // MARK: - Private properties

    private let userDefaults: UserDefaultsProtocol

    // MARK: - Initialisers

    init(userDefaults: UserDefaultsProtocol = UserDefaults.standard) {
        self.userDefaults = userDefaults
    }

    // MARK: - AppSettingsProtocol

    var baseURL: String { userDefaults.string(forKey: "baseURL") ?? "https://bruce-v2-mob.fairfaxmedia.com.au" }
}
