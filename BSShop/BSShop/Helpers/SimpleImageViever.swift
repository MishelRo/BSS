//
//  SimpleImageViever.swift
//  BSShop
//
//  Created by User on 20.08.2021.
//

import UIKit
import SimpleImageViewer
class SimpleImageViewer {
    func showImage(cell: CollectionViewCell) -> ImageViewerController {
        let images = cell.imageSet
        let conf = ImageViewerConfiguration { (image) in
            image.image = images?.image}
        let imageVC = ImageViewerController(configuration: conf)
        return imageVC
    }
}
