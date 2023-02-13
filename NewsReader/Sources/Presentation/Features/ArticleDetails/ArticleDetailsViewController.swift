import UIKit
import WebKit

final class ArticleDetailsViewController: UIViewController {
    // MARK: - Outlets

    @IBOutlet private var webView: WKWebView!

    // MARK: - Private properties

    private var asset: Asset!

    // MARK: - Lifecycle

    static func fromStoryboard(asset: Asset) -> Self {
        let viewController = UIStoryboard(name: "Main", bundle: .main)
            .instantiateViewController(identifier: String(describing: Self.self)) as! Self
        viewController.asset = asset
        return viewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        if let url = URL(string: asset.url) {
            webView.load(URLRequest(url: url))
        }
    }
}
