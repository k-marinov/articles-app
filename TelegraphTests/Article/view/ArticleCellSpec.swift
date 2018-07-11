import Quick
import Nimble

@testable import Telegraph

class ArticleCellSpec: QuickSpec {

    override func spec() {
        describe("ArticleCell") {
            let dataSource: TableViewDataSource<ArticleResource, ArticleCell> =
                TableViewDataSource<ArticleResource, ArticleCell>()
            let tableView: UITableView = UITableView(frame: CGRect(x: 0.0, y: 0.0, width: 320.0, height: 568.0))
            let articles: [ArticleResource] = [ArticleMother.createArticle()]

            beforeEach {
                dataSource.appendOnce(contentsOf: articles)
                tableView.register(
                    UINib(nibName: ArticleCell.identifier, bundle: nil),
                    forCellReuseIdentifier: ArticleCell.identifier)
                tableView.rowHeight = 50.0
                tableView.estimatedRowHeight = 50.0
                tableView.dataSource = dataSource
                tableView.delegate = dataSource
                tableView.reloadData()
            }

            describe("configureCell") {
                var cell: ArticleCell!

                context("when has article at given index path") {
                    beforeEach {
                        let indexPath: IndexPath = IndexPath(row: 0, section: 0)
                        cell = dataSource.tableView(tableView, cellForRowAt: indexPath) as! ArticleCell
                    }

                    it("configures cell at row 0 with correct values") {
                        expect(cell.headlineLabel.text).to(equal("The revenant"))
                        expect(cell.ratingLabel.text).to(equal("4"))
                        expect(cell.descriptionLabel.text).to(equal("Leo's beautiful endurance test"))
                        expect(cell.rightArrowImageView.image).notTo(beNil())
                    }
                }
            }
        }
    }

}
