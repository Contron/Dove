//
//  AutoFlowLayout.swift
//  Dove
//
//  Created by Connor Haigh on 11/10/2016.
//  Copyright © 2016 Connor Haigh. All rights reserved.
//

import UIKit

@IBDesignable public class AutoFlowLayout: UICollectionViewFlowLayout {
	override public func prepare() {
		super.prepare()
		
		guard let view = self.collectionView else {
			return
		}
		
		view.isScrollEnabled = true
		view.isPagingEnabled = false
			
		self.itemSize = CGSize(width: view.frame.size.width * self.multiplier, height: view.frame.size.height)
		
		self.scrollDirection = .horizontal
		self.minimumLineSpacing = self.spacing
		self.minimumInteritemSpacing = self.spacing
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
	
	@IBInspectable public var multiplier: CGFloat = 1
	@IBInspectable public var spacing: CGFloat = 8
}
