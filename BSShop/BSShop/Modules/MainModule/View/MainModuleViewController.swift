//
//  MainModuleViewController.swift
//  BSShop
//
//  Created by Mishel on 18/08/2021.
//  Copyright © 2021 BSShop. All rights reserved.
//

import UIKit
import Bond

final class MainModuleViewController: UIViewController, MainModuleViewProtocol {

    // MARK: - Public Properties
    var presenter: MainModulePresenterFromViewProtocol!
    private var networkManager: NetworkProtocol! {
        globalContainer.resolve(NetworkProtocol.self)
    }
    
    @IBOutlet weak var collectionView: UICollectionView!

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        presenter.getСategory()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "CollectionViewCell",
                                      bundle: nil), forCellWithReuseIdentifier: CollectionViewCell().reuseId
        )
        bindViewModel()
     
    }

    func bindViewModel() {
        self.presenter.observableCategories.bind(to: self) { [weak self] (strongSelf, photos) in
            self?.collectionView.reloadData()
        }
    
    }
    func reloadData() {
        collectionView.reloadData()
    }

    func selectedСategory(prod: [SubCategory]) {
        CategoryModuleViewController().getCategoryData(array: prod)
        Coordinator.shared.display(confViews: CategoryModuleConfigurator())
    }

}
extension MainModuleViewController: UICollectionViewDelegate,
                                    UICollectionViewDataSource,
                                    UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        presenter.observableCategories.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell().reuseId,
                                                      for: indexPath) as! CollectionViewCell
        let current = presenter.observableCategories.value[indexPath.row]
        cell.getimageDetail(urlString: current.imageUrl, title: current.name)
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
        let subcategories = presenter.observableCategories.value[indexPath.row].subcategories
              for item in subcategories {
                  networkManager.getProducts(item.id) { (_) in
                  }
    }
        selectedСategory(prod: subcategories)
}

}
