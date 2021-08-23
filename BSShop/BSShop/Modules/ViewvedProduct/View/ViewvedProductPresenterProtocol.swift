//
//  ViewvedProductPresenterProtocol.swift
//  BSShop
//
//  Created by Mishel on 20/08/2021.
//  Copyright © 2021 BSShop. All rights reserved.
//

import Foundation

protocol ViewvedProductPresenterFromViewProtocol: class {
    func viewDidLoad()
    func getViewedProductData(prod: Product)
    var images: [ProductImage] {get set}
    var products: Product? {get set}
}

protocol ViewvedProductPresenterFromInteractorProtocol: class {}

typealias ViewvedProductPresenterProtocol
    = ViewvedProductPresenterFromViewProtocol & ViewvedProductPresenterFromInteractorProtocol
