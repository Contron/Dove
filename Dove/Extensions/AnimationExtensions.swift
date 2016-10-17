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
		self.animateAlpha(1, block: block)
	}
	
	public func fadeOut(block: ActionBlock? = nil) {
		self.animateAlpha(0, block: block)
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
	
	public func fadeOutAndRemove(block: ActionBlock? = nil) {
		self.view.fadeOut(block: { [weak self] in
			self?.view.removeFromSuperview()
			self?.removeFromParentViewController()
			
			block?()
		})
	}
}

public extension UIView {
	public func animateVisible(_ visible: Bool, block: ActionBlock? = nil) {
		self.animateAlpha(CGFloat(visible ? 1 : 0), block: block)
	}
	
	public func animateAlpha(_ alpha: CGFloat, block: ActionBlock? = nil) {
		if self.alpha == alpha {
			return
		}
		
		UIView.animate(withDuration: animationConstant, animations: { [weak self] in
			self?.alpha = alpha
		}, completion: { finished in
			block?()
		})
	}
	
	public func animateCenter(_ center: CGPoint, block: ActionBlock? = nil) {
		if self.center == center {
			return
		}
		
		UIView.animate(withDuration: animationConstant, animations: { [weak self] in
			self?.center = center
		}, completion: { finished in
			block?()
		})
	}
	
	public func animateTransform(_ transform: CGAffineTransform, block: ActionBlock? = nil) {
		if self.transform == transform {
			return
		}
		
		UIView.animate(withDuration: animationConstant, animations: { [weak self] in
			self?.transform = transform
		}, completion: { finished in
			block?()
		})
	}
	
	public func animateLayout(block: ActionBlock? = nil) {
		UIView.animate(withDuration: animationConstant, animations: { [weak self] in
			self?.layoutIfNeeded()
		}, completion: { finished in
			block?()
		})
	}
}

public extension UILabel {
	public func animateText(_ text: String?, block: ActionBlock? = nil) {
		if self.text == text {
			return
		}
		
		UIView.transition(with: self, duration: animationConstant, options: .transitionFlipFromTop, animations: { [weak self] in
			self?.text = text
		}, completion: { finished in
			block?()
		})
	}
}

public extension UITextField {
	public func animateText(_ text: String?, block: ActionBlock? = nil) {
		if self.text == text {
			return
		}
		
		UIView.transition(with: self, duration: animationConstant, options: .transitionCrossDissolve, animations: { [weak self] in
			self?.text = text
		}, completion: { finished in
			block?()
		})
	}
}

public extension UIButton {
	public func animateEnabled(_ enabled: Bool, block: ActionBlock? = nil) {
		if self.isEnabled == enabled {
			return
		}
		
		UIView.transition(with: self, duration: animationConstant, options: .transitionCrossDissolve, animations: { [weak self] in
			self?.isEnabled = enabled
		}, completion: { finished in
			block?()
		})
	}
}

public extension UIImageView {
	public func animateImage(_ image: UIImage?, block: ActionBlock? = nil) {
		if self.image == image {
			return
		}
		
		UIView.transition(with: self, duration: animationConstant, options: .transitionFlipFromTop, animations: { [weak self] in
			self?.image = image
		}, completion: { finished in
			block?()
		})
	}
}
