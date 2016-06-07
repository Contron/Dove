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
		self.alpha = 0
		
		self.animateAlpha(1, block: block)
	}
	
	public func fadeOut(block: ActionBlock? = nil) {
		self.alpha = 1
		
		self.animateAlpha(0, block: block)
	}
	
	public func fadeOutAndRemove(block: ActionBlock? = nil) {
		self.fadeOut({ [weak self] in
			self?.removeFromSuperview()
			
			block?()
		})
	}
	
	public func animateVisible(visible: Bool, block: ActionBlock? = nil) {
		self.animateAlpha(CGFloat(visible ? 1 : 0), block: block)
	}
	
	public func animateAlpha(alpha: CGFloat, block: ActionBlock? = nil) {
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

public extension UIViewController {
	public func fadeIn(block: ActionBlock? = nil) {
		self.view.fadeIn(block)
	}
	
	public func fadeOut(block: ActionBlock? = nil) {
		self.view.fadeOut(block)
	}
	
	public func fadeOutAndRemove(block: ActionBlock? = nil) {
		self.view.fadeOut({ [weak self] in
			self?.removeFromParent()
			
			block?()
		})
	}
}

public extension UILabel {
	public func animateText(text: String?, block: ActionBlock? = nil) {
		if self.text == text {
			return
		}
		
		UIView.transitionWithView(self, duration: 0.3, options: .TransitionFlipFromTop, animations: { [weak self] in
			self?.text = text
		}, completion: { finished in
			block?()
		})
	}
}

public extension UITextField {
	public func animateText(text: String?, block: ActionBlock? = nil) {
		if self.text == text {
			return
		}
		
		UIView.transitionWithView(self, duration: 0.3, options: .TransitionCrossDissolve, animations: { [weak self] in
			self?.text = text
		}, completion: { finished in
			block?()
		})
	}
}

public extension UIButton {
	public func animateEnabled(enabled: Bool, block: ActionBlock? = nil) {
		if self.enabled == enabled {
			return
		}
		
		UIView.transitionWithView(self, duration: 0.3, options: .TransitionCrossDissolve, animations: { [weak self] in
			self?.enabled = enabled
		}, completion: { finished in
			block?()
		})
	}
}

public extension UIImageView {
	public func animateImage(image: UIImage?, block: ActionBlock? = nil) {
		if self.image == image {
			return
		}
		
		UIView.transitionWithView(self, duration: 0.3, options: .TransitionFlipFromTop, animations: { [weak self] in
			self?.image = image
		}, completion: { finished in
			block?()
		})
	}
}

public extension UITableView {
	public func animateReloadData(block: ActionBlock? = nil) {
		UIView.transitionWithView(self, duration: 0.35, options: .TransitionCrossDissolve, animations: { [weak self] in
			self?.reloadData()
		}, completion: { finished in
			block?()
		})
	}
}
