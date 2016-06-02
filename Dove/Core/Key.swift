//
//  Key.swift
//  Dove
//
//  Created by Connor Haigh on 02/06/2016.
//  Copyright © 2016 Connor Haigh. All rights reserved.
//

import Foundation

class Key {
	init(name: String) {
		self.name = name
	}
	
	let name: String
}

extension NSUserDefaults {
	subscript(key: Key) -> AnyObject? {
		get {
			return self.objectForKey(key.name)
		}
		set {
			self.setObject(newValue, forKey: key.name)
		}
	}
}
