protocol ArticleServiceProtocol {
    func getArticleList(completion: @escaping (Result<ArticleList, NetworkRequestError>) -> Void)
}

struct ArticleService: ArticleServiceProtocol {
    // MARK: - Private properties

    private let networkManager: NetworkManagerProtocol
    private let appSettings: AppSettingsProtocol

    // MARK: - Initialisers

    init(networkManager: NetworkManagerProtocol = NetworkManager(), appSettings: AppSettingsProtocol = AppSettings()) {
        self.networkManager = networkManager
        self.appSettings = appSettings
    }

    // MARK: - ArticleServiceProtocol

    func getArticleList(completion: @escaping (Result<ArticleList, NetworkRequestError>) -> Void) {
        networkManager.request(
            ArticleList.self, url: "\(appSettings.baseURL)/1/coding_test/13ZZQX/full", completion: completion
        )
    }
}
