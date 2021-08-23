//
//  DetailWhearControllerConfigurator.swift
//  BSShop
//
//  Created by Mishel on 19/08/2021.
//  Copyright © 2021 BSShop. All rights reserved.
//

import Swinject
import UIKit

final class DetailWhearControllerConfigurator: NSObject, Assembly {

    // MARK: - Public Properties
    public var container: Container!

    func assemble(container: Container) {
        self.container = container
        configure(container: container)
    }

    private func configure(container: Container) {

        // Assembly View Layer
        container
            .register(DetailWhearControllerViewProtocol.self) { _ in DetailWhearControllerViewController() }
            .initCompleted { r, c in
                guard let view = c as? DetailWhearControllerViewController else { return }
                view.presenter = r.resolve(DetailWhearControllerPresenterProtocol.self)
            }

        // Assembly Router Layer
        container
            .register(DetailWhearControllerRouterProtocol.self) { _ in DetailWhearControllerRouter() }
            .initCompleted { _, c in
                guard let router = c as? DetailWhearControllerRouter else { return }
                router.configurator = self
            }

        // Assembly Presenter Layer
        container
            .register(DetailWhearControllerPresenterProtocol.self) { _ in DetailWhearControllerPresenter() }
            .initCompleted { r, c in
                guard let presenter = c as? DetailWhearControllerPresenter else { return }
                presenter.view = r.resolve(DetailWhearControllerViewProtocol.self)
                presenter.router = r.resolve(DetailWhearControllerRouterProtocol.self)
                presenter.interactor = r.resolve(DetailWhearControllerInteractorProtocol.self)
            }

        // Assembly Interactor Layer
        container
            .register(DetailWhearControllerInteractorProtocol.self) { _ in DetailWhearControllerInteractor() }
            .initCompleted { r, c in
                guard let interactor = c as? DetailWhearControllerInteractor else { return }
                interactor.presenter = r.resolve(DetailWhearControllerPresenterProtocol.self)
            }
    }
}

// MARK: - ConfiguratorView
extension DetailWhearControllerConfigurator: ConfiguratorView {
    func getView() -> UIViewController {
        container.resolveAsViewController(DetailWhearControllerViewProtocol.self)
    }
}
