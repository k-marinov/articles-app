protocol ServiceCreatable {

    func create(with componentCreatable: ComponentCreatable) -> ArticleService

}

extension ServiceCreatable {

    func create(with componentCreatable: ComponentCreatable) -> ArticleService {
        return ArticleService(componentCreatable: componentCreatable)
    }

}
