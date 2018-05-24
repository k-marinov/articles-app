import Foundation
import UIKit
import Kingfisher

class ArticleCell: UITableViewCell, TableViewCell {

    static var identifier: String = "\(ArticleCell.self)"
//    @IBOutlet weak var outboundLegView: LegView!
//    @IBOutlet weak var inboundLegView: LegView!
//    @IBOutlet weak var priceLabel: UILabel!
//    @IBOutlet weak var flightComparisonLabel: UILabel!


    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configureCell(with tableViewItem: TableViewItem, indexPath: IndexPath) {
//        resetContent()
//        let flight: FlightRepresentable = tableViewItem as! FlightRepresentable
//        configureOutboundFlight(with: flight)
//        configureInboundFlight(with: flight)
//        priceLabel.text = flight.priceFormatted()
//        flightComparisonLabel.text = flight.priceComparisonFormatted()
    }

    private func resetContent() {
//        outboundLegView.resetContent()
//        inboundLegView.resetContent()
//        priceLabel.text = nil
//        flightComparisonLabel.text = nil
    }

}
