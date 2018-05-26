import UIKit
import RxSwift
import RxCocoa

class ArticleDetailViewController: UIViewController, ModelableViewController {

    private let disposeBag: DisposeBag = DisposeBag()
    private lazy var articleDetailViewModel: ArticleDetailViewModel = {
        return self.viewModel as! ArticleDetailViewModel
    }()
    var viewModel: ViewModel!

    @IBOutlet weak var headlineLabel: UILabel!
    @IBOutlet weak var pictureImageView: UIImageView!
    @IBOutlet weak var synopsisTitleLabel: UILabel!
    @IBOutlet weak var synopsisBodyLabel: UILabel!
    @IBOutlet weak var castTitleLabel: UILabel!
    @IBOutlet weak var castBodyLabel: UILabel!
    @IBOutlet weak var informationTitleLabel: UILabel!
    @IBOutlet weak var informationBodyLabel: UILabel!
    @IBOutlet weak var authorImageView: UIImageView!


    override func viewDidLoad() {
        super.viewDidLoad()
        subscribe()
    }

    private func subscribe() {
        articleDetailViewModel.detailRepresentable()
            .subscribe(onNext: { [weak self] detail in
                self?.setUp(detail: detail)
            }).disposed(by: disposeBag)
    }

    private func setUp(detail: ArticleDetailRepresentable) {
        setNavigationBarTitle(detail: detail)

        setPicture(detail: detail)
        setHeadline(detail: detail)
        setSynopsis(detail: detail)
        setCast(detail: detail)
        setInformation(detail: detail)
        setAuthorImage(detail: detail)
    }

    private func setPicture(detail: ArticleDetailRepresentable) {
        if let url = URL(string: detail.pictureUrl) {
            pictureImageView.kf.setImage(with: url)
        }
    }

    private func setNavigationBarTitle(detail: ArticleDetailRepresentable) {
        navigationItem.title = detail.headline
    }

    private func setHeadline(detail: ArticleDetailRepresentable) {
        headlineLabel.text = detail.headline
    }

    private func setSynopsis(detail: ArticleDetailRepresentable) {
        synopsisTitleLabel.text = "Synopsis"
        synopsisBodyLabel.text = detail.synopsis
    }

    private func setCast(detail: ArticleDetailRepresentable) {
        castTitleLabel.text = "Cast & Crew"
        castBodyLabel.text = detail.castAndCrew()
    }

    private func setInformation(detail: ArticleDetailRepresentable) {
        informationTitleLabel.text = "Information"
        informationBodyLabel.text = detail.information()
    }

    private func setAuthorImage(detail: ArticleDetailRepresentable) {
        if let url = URL(string: detail.author.imageUrl) {
            authorImageView.kf.setImage(with: url)
        }
    }

}
