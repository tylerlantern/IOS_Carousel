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
    var modelURLForImage :  [String]! {
        didSet {
            prioritizeLoadLastImageFirst()
        }
    }
    fileprivate var lastIndex : Int {
        get {
            return modelURLForImage.count - 1
        }
    }
    var virtualCount : Int {
        get {
            return modelURLForImage.count + 2
        }
    }
    func prioritizeLoadLastImageFirst() {
        let lastIndex = modelURLForImage.count - 1
        _ = api.loadImage(imagePath: modelURLForImage[lastIndex]) { (image, error) in
            self.modelCacheImageData[lastIndex] = image
        }
    }
    func bindDataToCell(cell : CarolselCell ,indexPath : IndexPath) {
        let lastIndex = modelURLForImage.count - 1
        if indexPath.item == 0 {
            cell.imv_forShowing.image = modelCacheImageData[lastIndex]
            
        }else if indexPath.item == modelURLForImage.count + 1{
            cell.imv_forShowing.image = modelCacheImageData[0]
        }else {
            
            let centainIndexPath = indexPath.item - 1
            
            if modelCacheImageData[centainIndexPath] == nil {
                cell.imv_forShowing.image  =  defaultImage
                cell.session = api.loadImage(imagePath: modelURLForImage[centainIndexPath ], completion: { (image, error) in
                    self.modelCacheImageData[centainIndexPath] = image
                })
            }else {
                cell.imv_forShowing.image = modelCacheImageData[centainIndexPath]
            }
            
        }
    }
}
