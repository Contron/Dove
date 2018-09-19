//
//  NodeExtensions.swift
//  Dove
//
//  Created by Connor Haigh on 11/10/2017.
//  Copyright © 2017 Connor Haigh. All rights reserved.
//

import Foundation
import SpriteKit

public extension SKNode {
	public func intersects(_ nodes: [SKNode]) -> Bool {
		return nodes.contains(where: { self.intersects($0) })
	}
}

public extension SKAction {
	public func timing(mode: SKActionTimingMode) -> SKAction {
		self.timingMode = mode
		
		return self
	}
	
	public func timing(function: @escaping SKActionTimingFunction) -> SKAction {
		self.timingFunction = function
		
		return self
	}
}
