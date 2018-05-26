import UIKit
import RxSwift

class TableViewDataSource<ITEM: TableViewItem, CELL: TableViewCell>: NSObject, UITableViewDataSource, UITableViewDelegate {

    private(set) var items: [TableViewItem] = [TableViewItem]()

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
            cell.configureCell(with: items[indexPath.row], indexPath: indexPath)
        }
        return cell as! UITableViewCell
    }

    func appendOnce(contentsOf newItems: [TableViewItem]) {
        items.removeAll()
        items.append(contentsOf: newItems)
    }

}
