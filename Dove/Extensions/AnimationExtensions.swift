//
//  AnimationExtensions.swift
//  Dove
//
//  Created by Connor Haigh on 02/06/2016.
//  Copyright © 2016 Connor Haigh. All rights reserved.
//

import Foundation
import UIKit

public extension UIView {
	public func fadeIn(block: ActionBlock? = nil) {
		self.animate(alpha: 1, block: block)
	}
	
	public func fadeOut(block: ActionBlock? = nil) {
		self.animate(alpha: 0, block: block)
	}
	
	public func fadeOutAndRemove(block: ActionBlock? = nil) {
		self.fadeOut(block: { [weak self] in
			self?.removeFromSuperview()
			
			block?()
		})
	}
}

public extension UIViewController {
	public func fadeIn(block: ActionBlock? = nil) {
		self.view.fadeIn(block: block)
	}
	
	public func fadeOut(block: ActionBlock? = nil) {
		self.view.fadeOut(block: block)
	}
}

public extension UIView {
	public func animate(alpha: CGFloat, block: ActionBlock? = nil) {
		UIView.animate(withDuration: animationConstant, animations: {
			self.alpha = alpha
		}, completion: { finished in
			block?()
		})
	}
	
	public func animate(center: CGPoint, block: ActionBlock? = nil) {
		UIView.animate(withDuration: animationConstant, animations: {
			self.center = center
		}, completion: { finished in
			block?()
		})
	}
	
	public func animate(transform: CGAffineTransform, block: ActionBlock? = nil) {
		UIView.animate(withDuration: animationConstant, animations: {
			self.transform = transform
		}, completion: { finished in
			block?()
		})
	}
	
	public func animateLayout(block: ActionBlock? = nil) {
		UIView.animate(withDuration: animationConstant, animations: {
			self.layoutIfNeeded()
		}, completion: { finished in
			block?()
		})
	}
}

public extension UILabel {
	public func animate(text: String?, block: ActionBlock? = nil) {
		UIView.transition(with: self, duration: animationConstant, options: .transitionFlipFromTop, animations: {
			self.text = text
		}, completion: { finished in
			block?()
		})
	}
}

public extension UITextField {
	public func animate(text: String?, block: ActionBlock? = nil) {
		UIView.transition(with: self, duration: animationConstant, options: .transitionCrossDissolve, animations: {
			self.text = text
		}, completion: { finished in
			block?()
		})
	}
}

public extension UIButton {
	public func animate(enabled: Bool, block: ActionBlock? = nil) {
		UIView.transition(with: self, duration: animationConstant, options: .transitionCrossDissolve, animations: {
			self.isEnabled = enabled
		}, completion: { finished in
			block?()
		})
	}
}

public extension UIImageView {
	public func animate(image: UIImage?, block: ActionBlock? = nil) {
		UIView.transition(with: self, duration: animationConstant, options: .transitionFlipFromTop, animations: {
			self.image = image
		}, completion: { finished in
			block?()
		})
	}
}
