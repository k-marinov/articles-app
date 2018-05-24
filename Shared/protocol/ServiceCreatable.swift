protocol ServiceCreatable {

    func create(with componentCreatable: ComponentCreatable) -> PricingService

}

extension ServiceCreatable {

    func create(with componentCreatable: ComponentCreatable) -> PricingService {
        return PricingService(componentCreatable: componentCreatable)
    }

}
