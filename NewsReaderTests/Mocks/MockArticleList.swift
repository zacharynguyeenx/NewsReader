@testable import NewsReader

extension ArticleList {
    static func mock(assets: [Asset] = [.mock()]) -> Self {
        .init(assets: assets)
    }
}

extension Asset {
    static func mock(
        url: String = "url",
        headline: String = "headline",
        theAbstract: String = "theAbstract",
        byLine: String = "byLine",
        relatedImages: [Asset.RelatedImage] = [.mock()],
        timeStamp: Int = 1
    ) -> Self {
        .init(
            url: url,
            headline: headline,
            theAbstract: theAbstract,
            byLine: byLine,
            relatedImages: relatedImages,
            timeStamp: timeStamp
        )
    }
}

extension Asset.RelatedImage {
    static func mock(url: String = "url", width: Int = 1, height: Int = 2) -> Self {
        .init(url: url, width: width, height: height)
    }
}
