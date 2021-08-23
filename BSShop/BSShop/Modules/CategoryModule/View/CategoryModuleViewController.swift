//
//  CategoryModuleViewController.swift
//  BSShop
//
//  Created by Mishel on 19/08/2021.
//  Copyright © 2021 BSShop. All rights reserved.
//

import UIKit

final class CategoryModuleViewController: UIViewController, CategoryModuleViewProtocol {

    // MARK: - Public Properties
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var backOutlets: UIButton!
    @IBOutlet weak var bayOutlet: UIButton!
    @IBOutlet weak var cancelButton: UIButton!

    static var subcat = [SubCategory]()
    var presenter: CategoryModulePresenterFromViewProtocol!
    private var networkManager: NetworkProtocol! {
        globalContainer.resolve(NetworkProtocol.self)
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: CollectionViewCell().reuseId, bundle: nil),
                                forCellWithReuseIdentifier: CollectionViewCell().reuseId)
        self.navigationItem.leftBarButtonItem = .init(title: Constants.titleBackButton,
                                                      style: .done, target: self,
                                                      action: #selector(backsBarButtonPress))
        self.navigationItem.rightBarButtonItem = .init(title: Constants.titleBasketButton,
                                                       style: .plain, target: self,
                                                       action: #selector(basketBarButtonPress))
    }

    func getCategoryData(array: [SubCategory]) {
        CategoryModuleViewController.subcat = array
        print(CategoryModuleViewController.subcat.count)
    }

    @objc func backsBarButtonPress() {
        Coordinator.shared.display(confViews: MainModuleConfigurator())
    }

    @objc func basketBarButtonPress() {
        Coordinator.shared.display(confViews: shoppingCartConfigurator())
    }
}

extension CategoryModuleViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        CategoryModuleViewController.subcat.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell().reuseId,
                                                      for: indexPath) as! CollectionViewCell
        let current = CategoryModuleViewController.subcat[indexPath.row]
        cell.getDataForCell(subcat: current)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let currentData = CategoryModuleViewController.subcat[indexPath.row]
        networkManager.getProducts(currentData.id) { (array) in
            Coordinator.shared.display(confViews: DetailWhearControllerConfigurator())
            DetailWhearControllerViewController().getDataDetailVC(array: array)
            DetailWhearControllerPresenter().getData(prod: array)
        }
    }
}

extension CategoryModuleViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let a: CGFloat = 2
        let b = 20 * (a + 1)
        let c = view.frame.width - b
        let d = c / a
        return CGSize(width: d, height: d)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return Constants.layautEdge
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(Constants.lineSpacing)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(Constants.lineSpacing)
    }
}
