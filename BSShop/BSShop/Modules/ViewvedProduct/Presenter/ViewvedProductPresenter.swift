//
//  ViewvedProductPresenter.swift
//  BSShop
//
//  Created by Mishel on 20/08/2021.
//  Copyright © 2021 BSShop. All rights reserved.
//

import Foundation

final class ViewvedProductPresenter: ViewvedProductPresenterFromViewProtocol {

    // MARK: - Public Properties

    weak var view: ViewvedProductViewProtocol!
    var interactor: ViewvedProductInteractorProtocol!
    var router: ViewvedProductRouterProtocol!
    var coreDataManager: CoreDataManagerProtocol!
    static  var prod: Product?
    var products: Product?
    var images = [ProductImage]()

    // MARK: - Protocol Implementation
    func viewDidLoad() {
        self.products = ViewvedProductPresenter.prod
        images = products!.productImages
    }

    func getViewedProductData(prod: Product) {
        ViewvedProductPresenter.prod = prod
    }

    func saveToBasket(prod: [Product]) {
        coreDataManager.saveData(array: prod)
    }
}

// MARK: - ViewvedProductPresenterFromInteractorProtocol Implementation
extension ViewvedProductPresenter: ViewvedProductPresenterFromInteractorProtocol {}
