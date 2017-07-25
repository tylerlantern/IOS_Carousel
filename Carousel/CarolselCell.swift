//
//  CarolselCell.swift
//  Carousel
//
//  Created by Nattapong Unaregul on 7/16/17.
//  Copyright © 2017 Nattapong Unaregul. All rights reserved.
//

import UIKit

class CarolselCell: UICollectionViewCell {
    static var cellIdentifier = "carolselCellIdentifier"
    var imv_forShowing: UIImageView = {
        let imv = UIImageView()
        imv.contentMode = .scaleToFill
        imv.translatesAutoresizingMaskIntoConstraints = false
        return imv
    }()
    
    var label : UILabel = {
        let lb = UILabel()
        lb.frame.size = CGSize(width: 100, height: 30)
        lb.textColor = UIColor.red
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        sharedInitilization()
    }
    var session : URLSessionDataTask?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        sharedInitilization()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        sharedInitilization()
    }
    
    func sharedInitilization() {
//        self.backgroundColor = UIColor.black
//        self.layer.borderColor = UIColor.blue.cgColor
//        self.layer.borderWidth = 10.0
        self.contentView.addSubview(imv_forShowing)
        let topAnchor = NSLayoutConstraint(item: imv_forShowing
            , attribute: .top , relatedBy: .equal , toItem: self, attribute: .top, multiplier: 1, constant: 0)
        let trailingAnchor = NSLayoutConstraint(item: imv_forShowing
            , attribute: .trailing , relatedBy: .equal , toItem: self, attribute: .trailing, multiplier: 1, constant: 0)
        let bottomAnchor = NSLayoutConstraint(item: imv_forShowing
            , attribute: .bottom , relatedBy: .equal , toItem: self, attribute: .bottom, multiplier: 1, constant: 0)
        let leftAnchor = NSLayoutConstraint(item: imv_forShowing
            , attribute: .leading , relatedBy: .equal , toItem: self, attribute: .leading, multiplier: 1, constant: 0)
        
        self.contentView.addSubview(label)
        let labelTopAnchor = NSLayoutConstraint(item: label
            , attribute: .top , relatedBy: .equal , toItem: self, attribute: .topMargin, multiplier: 1, constant: 0)
        let labelLeftAnchor = NSLayoutConstraint(item: label
            , attribute: .leading , relatedBy: .equal , toItem: self, attribute: .leadingMargin, multiplier: 1, constant: 0)
        NSLayoutConstraint.activate(
            [topAnchor,trailingAnchor,bottomAnchor,leftAnchor
                ,labelTopAnchor,labelLeftAnchor]
        )
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        self.imv_forShowing.image = nil
    }
}
