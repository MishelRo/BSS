//
//  shoppingCartViewController.swift
//  BSShop
//
//  Created by Mishel on 20/08/2021.
//  Copyright © 2021 BSShop. All rights reserved.
//

import UIKit

final class shoppingCartViewController: UIViewController, shoppingCartViewProtocol {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var totalPriceLabel: UILabel!
    
    // MARK: - Public Properties
    
    var presenter: shoppingCartPresenterFromViewProtocol!
    
    private var coreDataManager: CoreDataManagerProtocol! {
        globalContainer.resolve(CoreDataManagerProtocol.self)
    }
    var arrayOfFavoritePrice = [Int](){
        didSet{
            var sum = 0
            for item in arrayOfFavoritePrice{
                sum += item
            }
            totalPriceLabel.text = "total price is \(sum)"
        }
    }
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItem = .init(title: Constants.titleBackButton,
                                                      style: .done,
                                                      target: self,
                                                      action: #selector(backBarButtonPress))
        self.navigationItem.rightBarButtonItem = .init(title: "delete All",
                                                       style: .plain,
                                                       target: self,
                                                       action: #selector(deleteFromBasket))
        presenter.viewDidLoad()
        sumOfFav()
        totalPriceLabel.layer.cornerRadius = CGFloat(Constants.cornerRadius)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: CollectionViewCell().reuseId,
                                      bundle: nil), forCellWithReuseIdentifier: CollectionViewCell().reuseId)
        presenter.getData()
    }
    
    @objc func backBarButtonPress() {
        Coordinator.shared.display(confViews: CategoryModuleConfigurator())
    }
    @objc func deleteFromBasket() {
        coreDataManager.resetAllData()
        Coordinator.shared.display(confViews: shoppingCartConfigurator())
    }
    func sumOfFav(){
//        totalPriceLabel.text = "total Price\(arrayOfFavoritePrice.sum())"
  
    }
    
    
}
extension shoppingCartViewController: UICollectionViewDelegate,
                                      UICollectionViewDataSource,
                                      UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.arrayOfProd.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell().reuseId,
                                                      for: indexPath) as! CollectionViewCell
        cell.imageSet.contentMode = .scaleAspectFill
        let price = String(round(Double(presenter.arrayOfProd[indexPath.row].price)! ) )
        
        
        arrayOfFavoritePrice.append(Int(Double(presenter.arrayOfProd[indexPath.row].price)!))
        
        
        
        cell.getimageDetail(urlString: presenter.arrayOfProd[indexPath.row].imageUrl,
                            title: "\(price),P ")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! CollectionViewCell
        let imageVC = SimpleImageViewer().showImage(cell: cell)
        present(imageVC, animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView
                        , layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let a: CGFloat = 1
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
}
