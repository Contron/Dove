//
//  AspectFitImageView.swift
//  Dove
//
//  Created by Connor Haigh on 17/01/2017.
//  Copyright © 2017 Connor Haigh. All rights reserved.
//

import UIKit

@IBDesignable public class AspectFitImageView: UIImageView {
	required public init?(coder: NSCoder) {
		super.init(coder: coder)
		
		self.update()
	}
	
	override public init(image: UIImage?) {
		super.init(image: image)
		
		self.update()
	}
	
	override public init(frame: CGRect) {
		super.init(frame: frame)
		
		self.update()
	}
	
	public init() {
		super.init(frame: CGRect())
		
		self.update()
	}
	
	private func update() {
		guard let image = self.image else {
			return
		}
		
		if let constraint = self.constraint {
			self.removeConstraint(constraint)
		}
		
		let ratio = image.size.width / image.size.height
		let constraint = NSLayoutConstraint(item: self, attribute: .width, relatedBy: .equal, toItem: self, attribute: .height, multiplier: ratio, constant: 0)
		
		self.addConstraint(constraint)
	}
	
	override public var image: UIImage? {
		didSet {
			self.update()
		}
	}
	
	private var constraint: NSLayoutConstraint? = nil
}
