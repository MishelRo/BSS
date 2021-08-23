//
//  CategoryModulePresenter.swift
//  BSShop
//
//  Created by Mishel on 19/08/2021.
//  Copyright © 2021 BSShop. All rights reserved.
//

import Foundation

final class CategoryModulePresenter: CategoryModulePresenterFromViewProtocol {

    // MARK: - Public Properties

    weak var view: CategoryModuleViewProtocol!
    var interactor: CategoryModuleInteractorProtocol!
    var router: CategoryModuleRouterProtocol!

    // MARK: - Protocol Implementation

    func viewDidLoad() {
    }

}

// MARK: - CategoryModulePresenterFromInteractorProtocol Implementation
extension CategoryModulePresenter: CategoryModulePresenterFromInteractorProtocol {}
