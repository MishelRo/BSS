//
//  DetailWhearControllerPresenter.swift
//  BSShop
//
//  Created by Mishel on 19/08/2021.
//  Copyright © 2021 BSShop. All rights reserved.
//

import Foundation

final class DetailWhearControllerPresenter: DetailWhearControllerPresenterFromViewProtocol {

    // MARK: - Public Properties

    weak var view: DetailWhearControllerViewProtocol!
    var interactor: DetailWhearControllerInteractorProtocol!
    var router: DetailWhearControllerRouterProtocol!
    var prod: [Product]?
    // MARK: - Protocol Implementation

    func viewDidLoad() {
    }

    func getData(prod: [Product]) {
        self.prod = prod
    }
}
// MARK: - DetailWhearControllerPresenterFromInteractorProtocol Implementation
extension DetailWhearControllerPresenter: DetailWhearControllerPresenterFromInteractorProtocol {}
