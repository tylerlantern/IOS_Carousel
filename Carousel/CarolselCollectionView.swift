//
//  Carolsel.swift
//  Carousel
//
//  Created by Nattapong Unaregul on 7/16/17.
//  Copyright © 2017 Nattapong Unaregul. All rights reserved.
//

import UIKit

class CarolselCollectionView: UICollectionView,UICollectionViewDelegate
,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate {
   
    var defaultImageName : String = "" {
        
        didSet {
            if defaultImageName != "" {
                defaultImage = UIImage(named: defaultImageName)
            }
        }
    }

    fileprivate var defaultImage : UIImage?
    var viewModel = CarouselViewModel()
    let cellIdentifer = CarolselCell.cellIdentifier
    var pager : UIPageControl!
    var numberOfItems = 0
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        sharedInitilization()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        sharedInitilization()
    }
    init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout, pager : UIPageControl){
        super.init(frame: frame, collectionViewLayout: layout)
        self.pager = pager
        sharedInitilization()
    }
    func reloadDataWithProvidedImagesUrl( URLImages :[String]) {
        viewModel.modelURLForImage = URLImages
        viewModel.collectionView = self
        viewModel.defaultImage = self.defaultImage
        self.performBatchUpdates({
            self.reloadData()
        }) { (isFinished) in
            self.scrollToItem(at: IndexPath(item: 1, section: 0), at: UICollectionViewScrollPosition.centeredHorizontally, animated: false)
            self.pager.currentPage = 0
        }
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x == 0 {
            self.scrollToItem(at: IndexPath(item: viewModel.virtualCount - 2 , section: 0), at: UICollectionViewScrollPosition.centeredHorizontally, animated: false)
        }else if self.contentOffset.x == self.frame.width * CGFloat(viewModel.virtualCount - 1) {
            self.scrollToItem(at: IndexPath(item: 1, section: 0), at: UICollectionViewScrollPosition.centeredHorizontally, animated: false)
        }
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let rounderdNumber = Int(round(contentOffset.x / self.frame.width))
        switch rounderdNumber {
        case 0:
            pager.currentPage = numberOfItems - 1
            break;
        case numberOfItems - 1:
            pager.currentPage = 0
            break;
        default:
            pager.currentPage = rounderdNumber - 1
            break;
        }
    }
    func sharedInitilization (){
        self.delegate = self
        self.dataSource = self
        self.isPagingEnabled = true
        self.showsHorizontalScrollIndicator = false
        self.backgroundColor = UIColor.clear
        self.register(CarolselCell.self, forCellWithReuseIdentifier: cellIdentifer)
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.virtualCount
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.dequeueReusableCell(withReuseIdentifier: cellIdentifer, for: indexPath) as! CarolselCell
        viewModel.bindDataToCell(cell: cell, indexPath: indexPath)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.width, height: self.frame.height)
    }
    
}
