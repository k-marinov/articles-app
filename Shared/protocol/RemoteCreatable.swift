protocol RemoteCreatable {

    func create(with componentCreatable: ComponentCreatable) -> ArticleRemote

}

extension RemoteCreatable {

    func create(with componentCreatable: ComponentCreatable) -> ArticleRemote {
        return ArticleRemote(componentCreatable: componentCreatable)
    }

}
