import UIKit

final class ShowDetailViewController: UIViewController {

  private let viewModel: ShowDetailViewModel

  private lazy var rootView = ShowDetailView(
    showAllEpisodesAction: { [weak self] in self?.didTapShowAllEpisodes() }
  )

  var didTapShowAllEpisodes: (() -> Void)!
  var didTapShareButton: (() -> Void)!

  init(viewModel: ShowDetailViewModel) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    let detail = viewModel.loadDetail()
    rootView.render(detail)

    title = detail.name
    navigationItem.rightBarButtonItem = UIBarButtonItem(
      image: UIImage(systemName: "square.and.arrow.up"), style: .plain, target: self,
      action: #selector(shareTapped))
  }

  override func loadView() {
    view = rootView
  }

  @objc
  private func shareTapped() {
    didTapShareButton()
  }
}
