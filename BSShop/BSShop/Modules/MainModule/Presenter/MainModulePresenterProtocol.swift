//
//  MainModulePresenterProtocol.swift
//  BSShop
//
//  Created by Mishel on 18/08/2021.
//  Copyright © 2021 BSShop. All rights reserved.
//

import Foundation
import Bond
protocol MainModulePresenterFromViewProtocol: class {
    func viewDidLoad()
    func getСategory()
    func getData(arrayOfCategory: [ProductCategory], indexPath: IndexPath,
                 complession: @escaping([Product]) -> Void)
    var observableCategories: Observable<[ProductCategory]> {get set}

}

protocol MainModulePresenterFromInteractorProtocol: class {}

typealias MainModulePresenterProtocol
    = MainModulePresenterFromViewProtocol & MainModulePresenterFromInteractorProtocol
