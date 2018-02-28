//
//  ControlExtensions.swift
//  Dove
//
//  Created by Connor Haigh on 28/02/2018.
//  Copyright © 2018 Connor Haigh. All rights reserved.
//

import Foundation
import UIKit

public extension UIControl {
	public func addBlock(for controlEvents: UIControlEvents, block: @escaping ActionBlock) {
		let wrapper = Wrapper(block: block)
		var key = ObjectIdentifier(wrapper)
		
		self.addTarget(wrapper, action: #selector(Wrapper.invoke), for: controlEvents)
		
		objc_setAssociatedObject(self, &key, wrapper, .OBJC_ASSOCIATION_RETAIN)
	}
}

private class Wrapper {
	init(block: @escaping ActionBlock) {
		self.block = block
	}
	
	@objc func invoke() {
		self.block()
	}
	
	let block: ActionBlock
}
