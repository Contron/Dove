//
//  FitFlowLayout.swift
//  Dove
//
//  Created by Connor Haigh on 08/03/2017.
//  Copyright © 2017 Connor Haigh. All rights reserved.
//

import UIKit

@IBDesignable public final class FitFlowLayout: UICollectionViewFlowLayout {
	override public func prepare() {
		super.prepare()
		
		guard let view = self.collectionView else {
			return
		}
		
		view.isScrollEnabled = false
		view.isPagingEnabled = false
		
		self.itemSize = CGSize(width: view.frame.size.width / CGFloat(view.numberOfItems(inSection: 0)), height: view.frame.size.height)
		
		self.scrollDirection = .horizontal
		self.minimumLineSpacing = 0
		self.minimumInteritemSpacing = 0
	}
	
	override public func initialLayoutAttributesForAppearingItem(at itemIndexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
		guard let attributes = super.initialLayoutAttributesForAppearingItem(at: itemIndexPath) else {
			return nil
		}
		
		attributes.alpha = 0
		
		return attributes
	}
	
	override public func finalLayoutAttributesForDisappearingItem(at itemIndexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
		guard let attributes = super.finalLayoutAttributesForDisappearingItem(at: itemIndexPath) else {
			return nil
		}
		
		attributes.alpha = 0
		
		return attributes
	}
}
