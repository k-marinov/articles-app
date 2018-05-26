import Foundation
import UIKit
import Kingfisher

class ArticleCell: UITableViewCell, TableViewCell {

    static var identifier: String = "\(ArticleCell.self)"

    @IBOutlet weak var pictureImageView: UIImageView!
    @IBOutlet weak var ratingLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpRatingLabel()
    }

    func configureCell(with tableViewItem: TableViewItem, indexPath: IndexPath) {
        let representable = tableViewItem as! ArticleCellRepresentable
       resetContent()
        ratingLabel.text = "\(representable.rating!)"
//        let flight: FlightRepresentable = tableViewItem as! FlightRepresentable
//        configureOutboundFlight(with: flight)
//        configureInboundFlight(with: flight)
//        priceLabel.text = flight.priceFormatted()
//        flightComparisonLabel.text = flight.priceComparisonFormatted()

        if let url = URL(string: representable.pictureUrl) {
            print("picture url =\(representable.pictureUrl)")
            pictureImageView.kf.setImage(with: url)

        } else {
             print("failed picture url =\(representable.pictureUrl)")
        }
    }

    private func setUpRatingLabel() {
        let size: CGFloat = ratingLabel.frame.size.width
        ratingLabel.bounds = CGRect(x: 0, y: 0, width: size, height: size)
        ratingLabel.layer.cornerRadius = size / 2
        ratingLabel.layer.borderWidth = 1.0
        ratingLabel.layer.backgroundColor = UIColor.clear.cgColor
        ratingLabel.layer.borderColor = UIColor.white.cgColor
    }

    private func resetContent() {
        pictureImageView.image = nil
        ratingLabel.text = nil
//        outboundLegView.resetContent()
//        inboundLegView.resetContent()
//        priceLabel.text = nil
//        flightComparisonLabel.text = nil
    }

}
