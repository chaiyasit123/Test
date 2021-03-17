//
//  GridFlowLayout.swift
//  LuckyDraw
//
//  Created by S-Planet iOS on 6/20/2560 BE.
//  Copyright © 2560 S-Planet. All rights reserved.
//

import UIKit

class GridFlowLayout: UICollectionViewFlowLayout {

    // here you can define the height of each cell
    var itemHeight: CGFloat = 265
    
    override init() {
        super.init()
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLayout()
    }
    
    /**
     Sets up the layout for the collectionView. 1pt distance between each cell and 1pt distance between each row plus use a vertical layout
     */
    func setupLayout() {
        minimumInteritemSpacing = 10
        minimumLineSpacing = 10
        scrollDirection = .vertical
        sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        //  Re-design for small screen
        let height = UIScreen.main.nativeBounds.height
        if height <= Constant.IPHONE_5_HEIGHT {
            itemHeight = 245
        }
    }
    
    /// here we define the width of each cell, creating a 2 column layout. In case you would create 3 columns, change the number 2 to 3
    func itemWidth() -> CGFloat {
        return (collectionView!.frame.width / 2) - 15
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
