//
//  DetailWhearControllerViewController.swift
//  BSShop
//
//  Created by Mishel on 19/08/2021.
//  Copyright © 2021 BSShop. All rights reserved.
//

import UIKit

final class DetailWhearControllerViewController: UIViewController, DetailWhearControllerViewProtocol {

    // MARK: - Public Properties

    @IBOutlet weak var collectionView: UICollectionView!
    var presenter: DetailWhearControllerPresenterFromViewProtocol!
    static var arrayOfDetailWear = [Product]()

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        collectionView.register(UINib(nibName: "CollectionViewCell", bundle: nil),
                                forCellWithReuseIdentifier: CollectionViewCell().reuseId)
        collectionView.delegate = self
        collectionView.dataSource = self
        self.navigationItem.leftBarButtonItem = .init(title: Constants.titleBackButton,
                                                      style: .done,
                                                      target: self,
                                                      action: #selector(backBarButtonPress))
        self.navigationItem.rightBarButtonItem = .init(title: Constants.titleBasketButton,
                                                       style: .plain,
                                                       target: self,
                                                       action: #selector(basketBarButtonPress))
    }

    @objc func backBarButtonPress() {
        Coordinator.shared.display(confViews: CategoryModuleConfigurator())
    }
    @objc func basketBarButtonPress() {
        Coordinator.shared.display(confViews: shoppingCartConfigurator())
    }

    func getDataDetailVC(array: [Product]) {
        DetailWhearControllerViewController.arrayOfDetailWear = array
    }

}
extension DetailWhearControllerViewController: UICollectionViewDelegate,
                                               UICollectionViewDataSource,
                                               UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        DetailWhearControllerViewController.arrayOfDetailWear.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell().reuseId,
                                                      for: indexPath) as! CollectionViewCell
        let current = DetailWhearControllerViewController.arrayOfDetailWear[indexPath.row]
        cell.getDataForDetailCell(subcat: current)
        cell.imageSet.contentMode = .scaleAspectFill
        return cell
    }

    func collectionView(_ collectionView: UICollectionView
                        , layout collectionViewLayout: UICollectionViewLayout,
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

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(Constants.lineSpacing)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        Coordinator.shared.display(confViews: ViewvedProductConfigurator())
        let viewedProductArray = DetailWhearControllerViewController.arrayOfDetailWear[indexPath.row]
        ViewvedProductPresenter().getViewedProductData(prod: viewedProductArray)
    }
}
