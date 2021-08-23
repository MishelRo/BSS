//
//  shoppingCartPresenter.swift
//  BSShop
//
//  Created by Mishel on 20/08/2021.
//  Copyright © 2021 BSShop. All rights reserved.
//

import Foundation

final class shoppingCartPresenter: shoppingCartPresenterFromViewProtocol {

    // MARK: - Public Properties

    weak var view: shoppingCartViewProtocol!
    var interactor: shoppingCartInteractorProtocol!
    var router: shoppingCartRouterProtocol!
    var arrayOfProd = [CoreDataModel]()

    private var coreDataManager: CoreDataManagerProtocol! {
        globalContainer.resolve(CoreDataManagerProtocol.self)
    }
    // MARK: - Protocol Implementation

    func viewDidLoad() {
    }
    func getData() {
        coreDataManager.getData { (array) in
            self.arrayOfProd = array
        }
    }
}
// MARK: - shoppingCartPresenterFromInteractorProtocol Implementation
extension shoppingCartPresenter: shoppingCartPresenterFromInteractorProtocol {}
