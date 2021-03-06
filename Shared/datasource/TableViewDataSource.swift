import UIKit
import RxSwift

class TableViewDataSource<ITEM: TableViewItem, CELL: TableViewCell>: NSObject, UITableViewDataSource, UITableViewDelegate {

    private(set) var items: [TableViewItem] = [TableViewItem]()
    private(set) var didSelectRowAtIndexPath: PublishSubject<IndexPath> = PublishSubject<IndexPath>()

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CELL = tableView.dequeueReusableCell(withIdentifier: CELL.identifier, for: indexPath) as! CELL
        if indexPath.row < items.count {
            cell.configureCell(with: items[indexPath.row])
        }
        return cell as! UITableViewCell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelectRowAtIndexPath.onNext(indexPath)
    }

    func appendOnce(contentsOf newItems: [TableViewItem]) {
        items.removeAll()
        items.append(contentsOf: newItems)
    }

}
