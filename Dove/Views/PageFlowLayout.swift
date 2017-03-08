//
//  PageFlowLayout.swift
//  Dove
//
//  Created by Connor Haigh on 20/02/2017.
//  Copyright © 2017 Connor Haigh. All rights reserved.
//

import UIKit

@IBDesignable public class PageFlowLayout: UICollectionViewFlowLayout {
	override public func prepare() {
		super.prepare()
		
		if let view = self.collectionView {
			view.isScrollEnabled = true
			view.isPagingEnabled = true
			
			self.itemSize = CGSize(width: view.frame.size.width, height: view.frame.size.height)
		}
		
		self.scrollDirection = .horizontal
		
		self.minimumLineSpacing = 0
		self.minimumInteritemSpacing = 0
	}
	
	override public func initialLayoutAttributesForAppearingItem(at itemIndexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
		guard let attributes = super.initialLayoutAttributesForAppearingItem(at: itemIndexPath) else {
			return nil
		}
		
		attributes.alpha = 1
		
		return attributes
	}
	
	override public func finalLayoutAttributesForDisappearingItem(at itemIndexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
		guard let attributes = super.finalLayoutAttributesForDisappearingItem(at: itemIndexPath) else {
			return nil
		}
		
		attributes.alpha = 1
		
		return attributes
	}
}
