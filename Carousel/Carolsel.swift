//
//  CarolselControl.swift
//  Carousel
//
//  Created by Nattapong Unaregul on 7/16/17.
//  Copyright © 2017 Nattapong Unaregul. All rights reserved.
//

import UIKit

@IBDesignable
class Carolsel: UIControl {
    var defaultImageName = "" {
        didSet{
            if defaultImageName != "" {
                collectionView.defaultImageName = defaultImageName
            }
        }
    }
    private var collectionView : CarolselCollectionView!
    var pager : UIPageControl = {
        let p = UIPageControl()
        p.translatesAutoresizingMaskIntoConstraints = false
        return p
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        sharedInitilization()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        sharedInitilization()
    }
    func setUpImages(URLImages : [String]) {
        if URLImages.count == 0 {
            return
        }
        collectionView.pager.numberOfPages = URLImages.count
        collectionView.reloadDataWithProvidedImagesUrl(URLImages: URLImages)
    }
    func sharedInitilization(){
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView = CarolselCollectionView(frame: CGRect.zero, collectionViewLayout: layout,pager: pager)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(collectionView)
        self.addSubview(pager)
        
        
        let collectionViewTopAnchor = NSLayoutConstraint(item: collectionView
            , attribute: .top , relatedBy: .equal , toItem: self, attribute: .top, multiplier: 1, constant: 0)
        let collectionViewTrailingAnchor = NSLayoutConstraint(item: collectionView
            , attribute: .trailing , relatedBy: .equal , toItem: self, attribute: .trailing, multiplier: 1, constant: 0)
        let collectionViewBottomAnchor = NSLayoutConstraint(item: collectionView
            , attribute: .bottom , relatedBy: .equal , toItem: self, attribute: .bottom, multiplier: 1, constant: 1)
        let collectionViewLeftAnchor = NSLayoutConstraint(item: collectionView
            , attribute: .leading , relatedBy: .equal , toItem: self, attribute: .leading, multiplier: 1, constant: 0)
        
        let pagerCenterXConstraint = NSLayoutConstraint(item: pager, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0)
        let pagerVerticalSpacing = NSLayoutConstraint(item: pager, attribute: .bottom  , relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: 0)
        
        NSLayoutConstraint.activate([collectionViewTopAnchor,collectionViewTrailingAnchor,collectionViewBottomAnchor,collectionViewLeftAnchor,pagerCenterXConstraint,pagerVerticalSpacing])
    }
//    override func prepareForInterfaceBuilder() {
//        super.prepareForInterfaceBuilder()
//        pager.numberOfPages = 3
//        pager.pageIndicatorTintColor = UIColor.black
//        pager.currentPageIndicatorTintColor = UIColor.darkGray
//    }
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
}
