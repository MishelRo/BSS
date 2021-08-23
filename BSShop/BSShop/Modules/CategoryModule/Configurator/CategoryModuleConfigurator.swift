//
//  CategoryModuleConfigurator.swift
//  BSShop
//
//  Created by Mishel on 19/08/2021.
//  Copyright © 2021 BSShop. All rights reserved.
//

import Swinject
import UIKit

final class CategoryModuleConfigurator: NSObject, Assembly {

    // MARK: - Public Properties
    public var container: Container!

    func assemble(container: Container) {
        self.container = container
        configure(container: container)
    }

    private func configure(container: Container) {

        // Assembly View Layer
        container
            .register(CategoryModuleViewProtocol.self) { _ in CategoryModuleViewController() }
            .initCompleted { r, c in
                guard let view = c as? CategoryModuleViewController else { return }
                view.presenter = r.resolve(CategoryModulePresenterProtocol.self)
            }

        // Assembly Router Layer
        container
            .register(CategoryModuleRouterProtocol.self) { _ in CategoryModuleRouter() }
            .initCompleted { _, c in
                guard let router = c as? CategoryModuleRouter else { return }
                router.configurator = self
            }

        // Assembly Presenter Layer
        container
            .register(CategoryModulePresenterProtocol.self) { _ in CategoryModulePresenter() }
            .initCompleted { r, c in
                guard let presenter = c as? CategoryModulePresenter else { return }
                presenter.view = r.resolve(CategoryModuleViewProtocol.self)
                presenter.router = r.resolve(CategoryModuleRouterProtocol.self)
                presenter.interactor = r.resolve(CategoryModuleInteractorProtocol.self)
            }

        // Assembly Interactor Layer
        container
            .register(CategoryModuleInteractorProtocol.self) { _ in CategoryModuleInteractor() }
            .initCompleted { r, c in
                guard let interactor = c as? CategoryModuleInteractor else { return }
                interactor.presenter = r.resolve(CategoryModulePresenterProtocol.self)
            }
    }
}

// MARK: - ConfiguratorView
extension CategoryModuleConfigurator: ConfiguratorView {
    func getView() -> UIViewController {
        container.resolveAsViewController(CategoryModuleViewProtocol.self)
    }
}
