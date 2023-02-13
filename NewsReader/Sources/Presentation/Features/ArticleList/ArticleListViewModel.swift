final class ArticleListViewModel {
    // MARK: - Private properties

    private let articleService: ArticleServiceProtocol

    private var assets: [Asset] = [] {
        didSet {
            itemsCallback?(items)
        }
    }

    // MARK: - Initialisers

    init(articleService: ArticleServiceProtocol = ArticleService()) {
        self.articleService = articleService
    }

    // MARK: - Public

    var itemsCallback: (([ArticleListTileItem]) -> Void)?
    var showArticleDetaislCallback: ((Asset) -> Void)?
    var showNetworkErrorCallback: (() -> Void)?

    func getArticles(completion: @escaping () -> Void) {
        articleService.getArticleList { [weak self] result in
            switch result {
            case let .success(articleList): self?.assets = articleList.assets
            case .failure: self?.showNetworkErrorCallback?()
            }
            completion()
        }
    }
}

// MARK: - Private functions

private extension ArticleListViewModel {
    var items: [ArticleListTileItem] {
        assets
            .sorted { $0.timeStamp > $1.timeStamp }
            .map { asset in
                .init(asset: asset) { [weak self] in self?.showArticleDetaislCallback?(asset) }
            }
    }
}
