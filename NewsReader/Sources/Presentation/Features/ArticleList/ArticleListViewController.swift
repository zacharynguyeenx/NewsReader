import UIKit

final class ArticleListViewController: UIViewController {
    // MARK: - Outlets

    @IBOutlet private var collectionView: UICollectionView! {
        didSet {
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1 / 2), heightDimension: .estimated(300))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(300))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            let section = NSCollectionLayoutSection(group: group)
            collectionView.collectionViewLayout = UICollectionViewCompositionalLayout(section: section)

            collectionView.register(
                .init(nibName: String(describing: ArticleListTileItemCell.self), bundle: .main),
                forCellWithReuseIdentifier: String(describing: ArticleListTileItemCell.self)
            )

            collectionView.refreshControl = refreshControl
        }
    }

    @IBOutlet private var activityIndicator: UIActivityIndicatorView!

    // MARK: - Private properties

    private let viewModel = ArticleListViewModel()
    private var items: [ArticleListTileItem] = []

    private lazy var refreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefreshControl), for: .valueChanged)
        return refreshControl
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        configure(with: viewModel)

        viewModel.getArticles { [weak self] in
            self?.activityIndicator.isHidden = true
            self?.collectionView.isHidden = false
        }
    }
}

// MARK: - UICollectionViewDataSource

extension ArticleListViewController: UICollectionViewDataSource {
    func numberOfSections(in _: UICollectionView) -> Int { 1 }

    func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int { items.count }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: String(describing: ArticleListTileItemCell.self), for: indexPath
        ) as? ArticleListTileItemCell else {
            assertionFailure("Unrecognised cell")
            return UICollectionViewCell()
        }

        cell.configure(with: items[indexPath.item])

        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension ArticleListViewController: UICollectionViewDelegate {
    func collectionView(_: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        items[indexPath.item].action()
    }
}

// MARK: - Private functions

private extension ArticleListViewController {
    func configure(with viewModel: ArticleListViewModel) {
        viewModel.itemsCallback = { [weak self] in
            self?.items = $0
            self?.collectionView.reloadData()
        }

        viewModel.showArticleDetaislCallback = { [weak self] in
            let viewController = ArticleDetailsViewController.fromStoryboard(asset: $0)
            self?.navigationController?.pushViewController(viewController, animated: true)
        }

        viewModel.showNetworkErrorCallback = { [weak self] in
            let alert = UIAlertController(
                title: "Error", message: "There was a problem getting the articles", preferredStyle: .alert
            )
            alert.addAction(.init(title: "OK", style: .cancel))
            self?.present(alert, animated: true)
        }
    }

    @objc func handleRefreshControl() {
        viewModel.getArticles { [weak self] in self?.refreshControl.endRefreshing() }
    }
}
