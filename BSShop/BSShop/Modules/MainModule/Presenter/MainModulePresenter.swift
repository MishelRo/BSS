//
//  MainModulePresenter.swift
//  BSShop
//
//  Created by Mishel on 18/08/2021.
//  Copyright © 2021 BSShop. All rights reserved.
//

import Foundation
import Bond

final class MainModulePresenter: MainModulePresenterFromViewProtocol {
    
    // MARK: - Public Properties
    
    weak var view: MainModuleViewProtocol!
    var interactor: MainModuleInteractorProtocol!
    var router: MainModuleRouterProtocol!
    var observableCategories = Observable<[ProductCategory]>([])
    private var networkManager: NetworkProtocol! {
        globalContainer.resolve(NetworkProtocol.self)
    }
    
    // MARK: - Protocol Implementation
    func viewDidLoad() {
    }
    
    func getСategory() {
        networkManager.getCategories { [weak self](getCategories) in
            self?.observableCategories.value = getCategories
        }
    }
    
    func getData(arrayOfCategory: [ProductCategory],
                 indexPath: IndexPath,
                 complession: @escaping([Product]) -> Void) {
        let currentIndex = arrayOfCategory[indexPath.row].subcategories[indexPath.row].id
        networkManager.getProducts(currentIndex) { (array) in
            complession(array)
            self.view.reloadData()
        }
    }
}

// MARK: - MainModulePresenterFromInteractorProtocol Implementation
extension MainModulePresenter: MainModulePresenterFromInteractorProtocol {}
