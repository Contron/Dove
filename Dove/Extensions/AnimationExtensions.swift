//
//  AnimationExtensions.swift
//  Dove
//
//  Created by Connor Haigh on 02/06/2016.
//  Copyright © 2016 Connor Haigh. All rights reserved.
//

import Foundation
import UIKit

typealias AnimationBlock = Void -> Void

extension UIView {
	func fadeIn(block: AnimationBlock? = nil) {
		self.animateAlpha(1, block: block)
	}
	
	func fadeOut(block: AnimationBlock? = nil) {
		self.animateAlpha(0, block: block)
	}
	
	func fadeOutAndRemove() {
		self.fadeOut({ [weak self] in
			self?.removeFromSuperview()
		})
	}
	
	func animateVisible(hidden: Bool, block: AnimationBlock? = nil) {
		self.animateAlpha(CGFloat(hidden ? 0 : 1), block: block)
	}
	
	func animateAlpha(alpha: CGFloat, block: AnimationBlock? = nil) {
		if self.alpha == alpha {
			return
		}
		
		UIView.animateWithDuration(0.3, animations: { [weak self] in
			self?.alpha = alpha
		}, completion: { finished in
			block?()
		})
	}
}

extension UIViewController {
	func fadeIn(block: AnimationBlock? = nil) {
		self.view.fadeIn(block)
	}
	
	func fadeOut(block: AnimationBlock? = nil) {
		self.view.fadeOut(block)
	}
	
	func fadeOutAndRemove(block: AnimationBlock? = nil) {
		self.view.fadeOut({ [weak self] in
			self?.removeFromParent()
			
			block?()
		})
	}
}

extension UILabel {
	func animateText(text: String?, block: AnimationBlock? = nil) {
		if self.text == text {
			return
		}
		
		UIView.transitionWithView(self, duration: 0.35, options: .TransitionFlipFromTop, animations: { [weak self] in
			self?.text = text
		}, completion: { finished in
			block?()
		})
	}
}

extension UITextField {
	func animateText(text: String?, block: AnimationBlock? = nil) {
		if self.text == text {
			return
		}
		
		UIView.transitionWithView(self, duration: 0.35, options: .TransitionCrossDissolve, animations: { [weak self] in
			self?.text = text
		}, completion: { finished in
			block?()
		})
	}
}

extension UIButton {
	func animateEnabled(enabled: Bool, block: AnimationBlock? = nil) {
		if self.enabled == enabled {
			return
		}
		
		UIView.transitionWithView(self, duration: 0.35, options: .TransitionFlipFromTop, animations: { [weak self] in
			self?.enabled = enabled
		}, completion: { finished in
			block?()
		})
	}
}

extension UIImageView {
	func animateImage(image: UIImage, block: AnimationBlock? = nil) {
		if self.image == image {
			return
		}
		
		UIView.transitionWithView(self, duration: 0.35, options: .TransitionFlipFromTop, animations: { [weak self] in
			self?.image = image
		}, completion: { finished in
			block?()
		})
	}
}
