import Kingfisher
import UIKit

final class ArticleListTileItemCell: UICollectionViewCell {
    // MARK: - Outlets

    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var headlineLabel: UILabel!
    @IBOutlet private var abstractLabel: UILabel!
    @IBOutlet private var authorLabel: UILabel!

    // MARK: - Configurations

    func configure(with item: ArticleListTileItem) {
        imageView.kf.setImage(with: item.imageURL.flatMap(URL.init))
        headlineLabel.text = item.headline
        abstractLabel.text = item.abstract
        authorLabel.text = item.author
    }
}
