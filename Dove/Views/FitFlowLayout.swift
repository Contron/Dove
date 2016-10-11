//
//  FitFlowLayout.swift
//  Dove
//
//  Created by Connor Haigh on 11/10/2016.
//  Copyright © 2016 Connor Haigh. All rights reserved.
//

import UIKit

@IBDesignable public class FitFlowLayout: UICollectionViewFlowLayout {
	override public func prepare() {
		super.prepare()
		
		if let view = self.collectionView {
			view.isScrollEnabled = false
			view.isPagingEnabled = false
			
			let count = CGFloat(view.numberOfItems(inSection: 0))
			
			let items = (view.frame.size.width - (self.padding * 2)) / count
			let spacing = self.spacing * ((count - 1) / count)
			
			self.itemSize = CGSize(width: items - spacing, height: view.frame.size.height)
		}
		
		self.scrollDirection = .horizontal
		self.sectionInset = UIEdgeInsets(top: 0, left: self.padding, bottom: 0, right: self.padding)
		
		self.minimumLineSpacing = self.spacing
		self.minimumInteritemSpacing = self.spacing
	}
	
	@IBInspectable public var spacing: CGFloat = 8
	@IBInspectable public var padding: CGFloat = 8
}
