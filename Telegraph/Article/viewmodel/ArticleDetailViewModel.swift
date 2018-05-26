import RxSwift

class ArticleDetailViewModel: ViewModel {

    var detail: ArticleDetailRepresentable!

    required init(detail: ArticleDetailRepresentable) {
        self.detail = detail
    }

    func detailRepresentable() -> Observable<ArticleDetailRepresentable> {
        return Observable<ArticleDetailRepresentable>.just(detail)
    }

}
