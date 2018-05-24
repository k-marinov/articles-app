class ArticleService: Service {

    private var articleRemote: ArticleRemote

    required init(componentCreatable: ComponentCreatable) {
        articleRemote = componentCreatable.create(with: componentCreatable)
    }

}
