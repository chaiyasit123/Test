//
//  ListFlowLayout.swift
//  LuckyDraw
//
//  Created by S-Planet iOS on 6/20/2560 BE.
//  Copyright © 2560 S-Planet. All rights reserved.
//

import UIKit

class ListFlowLayout: UICollectionViewFlowLayout {

    let itemHeight: CGFloat = 128
    var spacing: CGFloat = 20
    
    override init() {
        super.init()
        setupLayout()
    }
    
    /**
     Init method
     
     - parameter aDecoder: aDecoder
     
     - returns: self
     */
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLayout()
    }
    
    /**
     Sets up the layout for the collectionView. 0 distance between each cell, and vertical layout
     */
    func setupLayout() {
        minimumInteritemSpacing = 0
        minimumLineSpacing = 10
        scrollDirection = .vertical
        sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    func itemWidth() -> CGFloat {
        return collectionView!.frame.width - spacing
    }
    
    override var itemSize: CGSize {
        set {
            self.itemSize = CGSize(width: itemWidth(), height: itemHeight)
        }
        get {
            return CGSize(width: itemWidth(), height: itemHeight)
        }
    }
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint) -> CGPoint {
        return collectionView!.contentOffset
    }
    
}
