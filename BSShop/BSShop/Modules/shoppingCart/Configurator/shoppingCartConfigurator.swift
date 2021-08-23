//
//  shoppingCartConfigurator.swift
//  BSShop
//
//  Created by Mishel on 20/08/2021.
//  Copyright © 2021 BSShop. All rights reserved.
//

import Swinject
import UIKit

final class shoppingCartConfigurator: NSObject, Assembly {

    // MARK: - Public Properties
    public var container: Container!

    func assemble(container: Container) {
        self.container = container
        configure(container: container)
    }

    private func configure(container: Container) {

        // Assembly View Layer
        container
            .register(shoppingCartViewProtocol.self) { _ in shoppingCartViewController() }
            .initCompleted { r, c in
                guard let view = c as? shoppingCartViewController else { return }
                view.presenter = r.resolve(shoppingCartPresenterProtocol.self)
            }

        // Assembly Router Layer
        container
            .register(shoppingCartRouterProtocol.self) { _ in shoppingCartRouter() }
            .initCompleted { _, c in
                guard let router = c as? shoppingCartRouter else { return }
                router.configurator = self
            }

        // Assembly Presenter Layer
        container
            .register(shoppingCartPresenterProtocol.self) { _ in shoppingCartPresenter() }
            .initCompleted { r, c in
                guard let presenter = c as? shoppingCartPresenter else { return }
                presenter.view = r.resolve(shoppingCartViewProtocol.self)
                presenter.router = r.resolve(shoppingCartRouterProtocol.self)
                presenter.interactor = r.resolve(shoppingCartInteractorProtocol.self)
            }

        // Assembly Interactor Layer
        container
            .register(shoppingCartInteractorProtocol.self) { _ in shoppingCartInteractor() }
            .initCompleted { r, c in
                guard let interactor = c as? shoppingCartInteractor else { return }
                interactor.presenter = r.resolve(shoppingCartPresenterProtocol.self)
            }
    }
}

// MARK: - ConfiguratorView
extension shoppingCartConfigurator: ConfiguratorView {
    func getView() -> UIViewController {
        container.resolveAsViewController(shoppingCartViewProtocol.self)
    }
}
