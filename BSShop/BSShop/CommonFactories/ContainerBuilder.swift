//
//  ContainerBuilder.swift
//  Set2
//
//  Created by Mishel on 03/08/2021.
//  Copyright © 2021 Set. All rights reserved.
//
import Foundation
import Swinject

final class ContainerBuilder {

    // MARK: - Private Properties
    private var container: Container!

    // MARK: - Lifecycle

    init() {
        self.container = Container(defaultObjectScope: .container)
    }

    // MARK: - Building

    @discardableResult
    func addAlerts() -> ContainerBuilder {
        return self
    }

    @discardableResult
    func addServices() -> ContainerBuilder {
        container.register(MainStartProtocol.self) { _ in
            ServicesContainer.shared.resolve(MainStartProtocol.self)!
        }
        container.register(CoreDataManagerProtocol.self) { _ in
            ServicesContainer.shared.resolve(CoreDataManagerProtocol.self)!
        }
        container.register(NetworkProtocol.self) { _ in
            ServicesContainer.shared.resolve(NetworkProtocol.self)!
        }
        return self
    }

    @discardableResult
    func addAnalytics() -> ContainerBuilder {
        self
    }

    @discardableResult
    func addLogging() -> ContainerBuilder {
        return self
    }

    func build() -> Container {
        self.container
    }

}
