//
//  MainModuleConfigurator.swift
//  BSShop
//
//  Created by Mishel on 18/08/2021.
//  Copyright © 2021 BSShop. All rights reserved.
//

import Swinject
import UIKit

final class MainModuleConfigurator: NSObject, Assembly {

    // MARK: - Public Properties
    public var container: Container!

    func assemble(container: Container) {
        self.container = container
        configure(container: container)
    }

    private func configure(container: Container) {

        // Assembly View Layer
        container
            .register(MainModuleViewProtocol.self) { _ in MainModuleViewController() }
            .initCompleted { r, c in
                guard let view = c as? MainModuleViewController else { return }
                view.presenter = r.resolve(MainModulePresenterProtocol.self)
            }

        // Assembly Router Layer
        container
            .register(MainModuleRouterProtocol.self) { _ in MainModuleRouter() }
            .initCompleted { _, c in
                guard let router = c as? MainModuleRouter else { return }
                router.configurator = self
            }

        // Assembly Presenter Layer
        container
            .register(MainModulePresenterProtocol.self) { _ in MainModulePresenter() }
            .initCompleted { r, c in
                guard let presenter = c as? MainModulePresenter else { return }
                presenter.view = r.resolve(MainModuleViewProtocol.self)
                presenter.router = r.resolve(MainModuleRouterProtocol.self)
                presenter.interactor = r.resolve(MainModuleInteractorProtocol.self)
            }

        // Assembly Interactor Layer
        container
            .register(MainModuleInteractorProtocol.self) { _ in MainModuleInteractor() }
            .initCompleted { r, c in
                guard let interactor = c as? MainModuleInteractor else { return }
                interactor.presenter = r.resolve(MainModulePresenterProtocol.self)
            }
    }
}

// MARK: - ConfiguratorView
extension MainModuleConfigurator: ConfiguratorView {
    func getView() -> UIViewController {
        container.resolveAsViewController(MainModuleViewProtocol.self)
    }
}
