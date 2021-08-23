//
//  ServiceContainer.swift
//  Set2
//
//  Created by Mishel on 03/08/2021.
//  Copyright © 2021 Set. All rights reserved.
//

import Foundation
import Swinject

final class ServicesContainer {
    static let shared = ServicesContainer()
    public let container = Container()

    init(
        mainStart: MainStartProtocol = MainStart.shared,
        network: NetworkProtocol = Network.shared,
        coreDataManager: CoreDataManagerProtocol = CoreDataManager.shared
    ) {
        container.register(MainStartProtocol.self) { _ in mainStart }
        container.register(NetworkProtocol.self) { _ in network }
        container.register(CoreDataManagerProtocol.self, factory: { _ in coreDataManager })
    }

    func resolve<Service>(_ protocol: Service.Type) -> Service? {
        container.resolve(Service.self)
    }

    @discardableResult
    public func register<Service>(_ serviceType: Service.Type,
                                  name: String? = nil,
                                  factory: @escaping (Resolver) -> Service) -> ServiceEntry<Service> {
        container.register(serviceType, name: name, factory: factory)
    }
}
