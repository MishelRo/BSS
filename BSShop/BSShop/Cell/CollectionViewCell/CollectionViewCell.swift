//
//  CollectionViewCell.swift
//  BSShop
//
//  Created by User on 19.08.2021.
//

import UIKit
import SDWebImage
class CollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageSet: UIImageView!
    @IBOutlet weak var labelCell: UILabel!

    var reuseId = "CollectionViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func getDataForCell(subcat: SubCategory) {
        layer.cornerRadius = CGFloat(Constants.cornerRadius)
        backgroundColor = .white
        labelCell.textColor = .black
        labelCell.text = subcat.name
        let url = URL(string: "\(Constants.urlStr)\(subcat.iconImage)")
//        imageSet.sd_setImage(with: url, completed: nil)
        imageSet.sd_setImage(with: url,
                             placeholderImage: UIImage(named: "present"),
                             options: .fromLoaderOnly,
                             context: nil)
        imageSet.layer.cornerRadius = CGFloat(Constants.cornerRadius)
    }

    func getDataForDetailCell(subcat: Product) {
        labelCell.text = subcat.name
        let url = URL(string: "\(Constants.urlStr)\(subcat.mainImage)")
        imageSet.sd_setImage(with: url,
                             placeholderImage: UIImage(named: "present"),
                             options: .fromLoaderOnly,
                             context: nil)
        imageSet.layer.cornerRadius = CGFloat(Constants.cornerRadius)
    }

    func getimage(urlString: String, title: Product) {
        let url = URL(string: "\(Constants.urlStr)\(urlString)")
        imageSet.layer.cornerRadius = CGFloat(Constants.cornerRadius)
        imageSet.sd_setImage(with: url,
                             placeholderImage: UIImage(named: "present"),
                             options: .fromLoaderOnly,
                             context: nil)
        labelCell.text = title.name
    }

    func getimageDetail(urlString: String, title: String) {
        let url = URL(string: "\(Constants.urlStr)\(urlString)")
        imageSet.sd_setImage(with: url,
                             placeholderImage: UIImage(named: "present"),
                             options: .fromLoaderOnly,
                             context: nil)
        imageSet.layer.cornerRadius = CGFloat(Constants.cornerRadius)
        labelCell.text = title
    }

    override func prepareForReuse() {
        super.prepareForReuse()
    }

}
