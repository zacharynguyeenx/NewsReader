import Foundation

struct ArticleList: Codable, Equatable {
    let assets: [Asset]
}

struct Asset: Codable, Equatable {
    let url: String
    let headline: String
    let theAbstract: String
    let byLine: String
    let relatedImages: [RelatedImage]
    let timeStamp: Int
}

extension Asset {
    struct RelatedImage: Codable, Equatable {
        let url: String
        let width: Int
        let height: Int
    }
}
