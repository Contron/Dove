//
//  AspectFitButton.swift
//  Dove
//
//  Created by Connor Haigh on 08/06/2016.
//  Copyright © 2016 Connor Haigh. All rights reserved.
//

import UIKit

@IBDesignable public class AspectFitButton: UIButton {
	public override func awakeFromNib() {
		super.awakeFromNib()
		
		self.fit()
	}
	
	public override func layoutSubviews() {
		super.layoutSubviews()
		
		self.fit()
	}
	
	private func fit() {
		if self.scaleSelf {
			self.contentMode = .ScaleAspectFit
		}
		
		if self.scaleImageViews {
			for view in self.subviews {
				if view is UIImageView {
					view.contentMode = .ScaleAspectFit
				}
			}
		}
	}
	
	@IBInspectable public var scaleSelf = true
	@IBInspectable public var scaleImageViews = true
}
