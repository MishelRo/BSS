//
//  shoppingCartPresenterProtocol.swift
//  BSShop
//
//  Created by Mishel on 20/08/2021.
//  Copyright © 2021 BSShop. All rights reserved.
//

import Foundation

protocol shoppingCartPresenterFromViewProtocol: class {
    func viewDidLoad()
    func getData()
    var arrayOfProd: [CoreDataModel] {get set}

}

protocol shoppingCartPresenterFromInteractorProtocol: class {}

typealias shoppingCartPresenterProtocol
    = shoppingCartPresenterFromViewProtocol & shoppingCartPresenterFromInteractorProtocol
