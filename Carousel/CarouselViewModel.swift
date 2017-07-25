//
//  CarouselViewModel.swift
//  Carousel
//
//  Created by Nattapong Unaregul on 7/22/17.
//  Copyright © 2017 Nattapong Unaregul. All rights reserved.
//
import  UIKit
class CarouselViewModel: NSObject {
    let api = CarolselAPI()
    var modelCacheImageData = Dictionary<Int,UIImage>()
    var collectionView : UICollectionView?
    var defaultImage : UIImage?
    var modelURLForImage :  [String]?  {
        didSet {
            if modelURLForImage != nil {
                prioritizeLoadLastImageFirst()
            }
        }
    }
    fileprivate var lastIndex : Int {
        get {
            return modelURLForImage == nil ? 0  : modelURLForImage!.count - 1
        }
    }
    var virtualCount : Int {
        get {
            return modelURLForImage == nil ? 0  : modelURLForImage!.count + 2
        }
    }
    func prioritizeLoadLastImageFirst() {
        let lastIndex = modelURLForImage!.count - 1
        _ = api.loadImage(imagePath: modelURLForImage![lastIndex]) { (image, error) in
            self.modelCacheImageData[lastIndex] = image
            for indexPath in self.collectionView!.indexPathsForVisibleItems.filter({ (indexPath) -> Bool in
                return (indexPath.item == 0 || indexPath.item == self.lastIndex + 1 ) ? true  : false
            }) {
                let cell = self.collectionView?.cellForItem(at: indexPath) as? CarolselCell
                cell?.imv_forShowing.image = self.modelCacheImageData[lastIndex]
            }
        }
    }
    func bindDataToCell(cell : CarolselCell ,indexPath : IndexPath) {
        cell.label.text = String(indexPath.item)
        var centainIndex : Int!
        switch indexPath.item {
        case 0 :
            centainIndex = lastIndex
        case virtualCount - 1:
            centainIndex = 0
        default:
            centainIndex = indexPath.item - 1
        }
        if modelCacheImageData[centainIndex] == nil {
            cell.imv_forShowing.image  =  defaultImage
            cell.session = api.loadImage(imagePath: modelURLForImage![centainIndex ], completion: { (image, error) in
                self.modelCacheImageData[centainIndex] = image
                cell.imv_forShowing.image = image
            })
        }else {
            cell.imv_forShowing.image = modelCacheImageData[centainIndex]
        }
    }
}
