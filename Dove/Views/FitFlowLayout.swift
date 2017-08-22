//
//  FitFlowLayout.swift
//  Dove
//
//  Created by Connor Haigh on 08/03/2017.
//  Copyright © 2017 Connor Haigh. All rights reserved.
//

import UIKit

@IBDesignable public class FitFlowLayout: UICollectionViewFlowLayout {
	override public func prepare() {
		super.prepare()
		
		guard let view = self.collectionView else {
			return
		}
		
		view.isScrollEnabled = false
		view.isPagingEnabled = false
		
		let items = view.numberOfItems(inSection: 0)
		
		if items > 0 {
			let count = CGFloat(items)
			let offset = (self.spacing * (count - 1)) / count
			
			self.itemSize = CGSize(width: (view.frame.size.width / count) - offset, height: view.frame.size.height)
		} else {
			self.itemSize = CGSize(width: view.frame.size.width, height: view.frame.size.height)
		}
		
		self.scrollDirection = .horizontal
		
		self.minimumLineSpacing = self.spacing
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
	
	@IBInspectable public var spacing: CGFloat = 8
}
