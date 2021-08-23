//
//  DetailWhearControllerPresenterProtocol.swift
//  BSShop
//
//  Created by Mishel on 19/08/2021.
//  Copyright © 2021 BSShop. All rights reserved.
//

import Foundation

protocol DetailWhearControllerPresenterFromViewProtocol: class {
    func viewDidLoad()
    var prod: [Product]? {get set}

}

protocol DetailWhearControllerPresenterFromInteractorProtocol: class {}

typealias DetailWhearControllerPresenterProtocol
    = DetailWhearControllerPresenterFromViewProtocol & DetailWhearControllerPresenterFromInteractorProtocol
