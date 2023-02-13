struct ArticleListTileItem {
    let imageURL: String?
    let headline: String
    let abstract: String
    let author: String
    let action: () -> Void

    init(imageURL: String? = nil, headline: String, abstract: String, author: String, action: @escaping () -> Void) {
        self.imageURL = imageURL
        self.headline = headline
        self.abstract = abstract
        self.author = author
        self.action = action
    }
}

extension ArticleListTileItem {
    init(asset: Asset, action: @escaping () -> Void) {
        self.init(
            imageURL: asset.relatedImages.sorted { $0.height * $0.width > $1.height * $1.width }.first?.url,
            headline: asset.headline,
            abstract: asset.theAbstract,
            author: asset.byLine,
            action: action
        )
    }
}
