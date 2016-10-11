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
		
		if let view = self.collectionView {
			self.itemSize = CGSize(width: view.frame.size.width * self.multiplier, height: view.frame.size.height)
		}
		
		self.scrollDirection = .horizontal
		
		self.minimumLineSpacing = self.spacing
		self.minimumInteritemSpacing = self.spacing
	}
	
	@IBInspectable public var multiplier: CGFloat = 1
	@IBInspectable public var spacing: CGFloat = 8
}
