//
//  ViewvedProductConfigurator.swift
//  BSShop
//
//  Created by Mishel on 20/08/2021.
//  Copyright © 2021 BSShop. All rights reserved.
//

import Swinject
import UIKit

final class ViewvedProductConfigurator: NSObject, Assembly {

    // MARK: - Public Properties
    public var container: Container!

    func assemble(container: Container) {
        self.container = container
        configure(container: container)
    }

    private func configure(container: Container) {

        // Assembly View Layer
        container
            .register(ViewvedProductViewProtocol.self) { _ in ViewvedProductViewController() }
            .initCompleted { r, c in
                guard let view = c as? ViewvedProductViewController else { return }
                view.presenter = r.resolve(ViewvedProductPresenterProtocol.self)
            }

        // Assembly Router Layer
        container
            .register(ViewvedProductRouterProtocol.self) { _ in ViewvedProductRouter() }
            .initCompleted { _, c in
                guard let router = c as? ViewvedProductRouter else { return }
                router.configurator = self
            }

        // Assembly Presenter Layer
        container
            .register(ViewvedProductPresenterProtocol.self) { _ in ViewvedProductPresenter() }
            .initCompleted { r, c in
                guard let presenter = c as? ViewvedProductPresenter else { return }
                presenter.view = r.resolve(ViewvedProductViewProtocol.self)
                presenter.router = r.resolve(ViewvedProductRouterProtocol.self)
                presenter.interactor = r.resolve(ViewvedProductInteractorProtocol.self)
            }

        // Assembly Interactor Layer
        container
            .register(ViewvedProductInteractorProtocol.self) { _ in ViewvedProductInteractor() }
            .initCompleted { r, c in
                guard let interactor = c as? ViewvedProductInteractor else { return }
                interactor.presenter = r.resolve(ViewvedProductPresenterProtocol.self)
            }
    }
}

// MARK: - ConfiguratorView
extension ViewvedProductConfigurator: ConfiguratorView {
    func getView() -> UIViewController {
        container.resolveAsViewController(ViewvedProductViewProtocol.self)
    }
}
