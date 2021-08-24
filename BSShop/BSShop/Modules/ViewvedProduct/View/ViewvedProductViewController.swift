//
//  ViewvedProductViewController.swift
//  BSShop
//
//  Created by Mishel on 20/08/2021.
//  Copyright © 2021 BSShop. All rights reserved.
//

import UIKit
import SimpleImageViewer
final class ViewvedProductViewController: UIViewController, ViewvedProductViewProtocol {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var firstLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var basketOutlet: UIButton!
    
    private var coreDataManager: CoreDataManagerProtocol! {
        globalContainer.resolve(CoreDataManagerProtocol.self)
    }
    
    @IBAction func basket(_ sender: Any) {
        guard let currentProduct = currentProduct else {return}
        productArrayToSave.append(currentProduct)
        coreDataManager.saveData(array: productArrayToSave)
    }
    
    // MARK: - Public Properties
    var presenter: ViewvedProductPresenterFromViewProtocol!
    var productArrayToSave = [Product]()
    var currentProduct: Product?
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        basketOutlet.layer.cornerRadius = 10
        self.navigationItem.leftBarButtonItem = .init(title: Constants.titleBackButton,
                                                      style: .done,
                                                      target: self,
                                                      action: #selector(backBarButtonPress))
        self.navigationItem.rightBarButtonItem = .init(title: Constants.titleBasketButton,
                                                       style: .plain,
                                                       target: self,
                                                       action: #selector(adToBasket))
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: CollectionViewCell().reuseId,
                                      bundle: nil), forCellWithReuseIdentifier: CollectionViewCell().reuseId)
        collectionView.isPagingEnabled = true
    }
    
    @objc func backBarButtonPress() {
        Coordinator.shared.display(confViews: DetailWhearControllerConfigurator())
    }
    
    @objc func adToBasket() {
        Coordinator.shared.display(confViews: shoppingCartConfigurator())
    }
    
    func reloadData() {
        collectionView.reloadData()
    }
}

extension ViewvedProductViewController: UICollectionViewDelegate,
                                        UICollectionViewDataSource,
                                        UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout
                            collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height:
                        collectionView.frame.size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.images.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell().reuseId,
                                                      for: indexPath) as! CollectionViewCell
        cell.imageSet.contentMode = .scaleAspectFill
        cell.getimage(urlString: presenter.images[indexPath.row].imageURL, title: presenter.products!)
        cell.layer.cornerRadius = CGFloat(Constants.cornerRadius)
        currentProduct = presenter.products
        firstLabel.text = "Цена: \(Int(round(Double(presenter.products!.price)!)))"
        secondLabel.text = "\(presenter.products!.description)"
        return cell
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! CollectionViewCell
        let imageVC = SimpleImageViewer().showImage(cell: cell)
        present(imageVC, animated: true, completion: nil)
    }
}
