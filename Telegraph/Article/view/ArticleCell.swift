import Foundation
import UIKit
import Kingfisher

class ArticleCell: UITableViewCell, TableViewCell {

    static var identifier: String = "\(ArticleCell.self)"

    @IBOutlet weak var pictureImageView: UIImageView!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var headlineLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var rightArrowImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        setUp()
    }

    func configureCell(with tableViewItem: TableViewItem, indexPath: IndexPath) {
        resetContent()
        setContent(with: tableViewItem)
    }

    private func setContent(with tableViewItem: TableViewItem) {
        let representable = tableViewItem as! ArticleCellRepresentable
        ratingLabel.text = "\(representable.rating!)"
        headlineLabel.text = representable.headline
        descriptionLabel.text = representable.description
        rightArrowImageView.image = ImageCreator.rightArrowImage(
            withLenght: rightArrowImageView.frame.size.width, color: UIColor.gray)
        if let url = URL(string: representable.pictureUrl) {
            pictureImageView.kf.setImage(with: url)
        }
    }

    private func setUpRatingLabel() {
        let size: CGFloat = ratingLabel.frame.size.width
        ratingLabel.bounds = CGRect(x: 0, y: 0, width: size, height: size)
        ratingLabel.layer.cornerRadius = size / 2.0
        ratingLabel.layer.borderWidth = 1.0
        ratingLabel.layer.backgroundColor = UIColor.clear.cgColor
        ratingLabel.layer.borderColor = UIColor.white.cgColor
    }

    private func resetContent() {
        pictureImageView.image = nil
        ratingLabel.text = nil
        headlineLabel.text = nil
        descriptionLabel.text = nil
    }

    private func setUp() {
        selectionStyle = UITableViewCellSelectionStyle.none
        setUpRatingLabel()
    }

}
