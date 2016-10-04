//
//  DictionaryExtensions.swift
//  Dove
//
//  Created by Connor Haigh on 10/08/2016.
//  Copyright © 2016 Connor Haigh. All rights reserved.
//

import Foundation

public extension Dictionary {
	public func collapse<Key: Hashable, Value>(transform: (Element) -> (Key?, Value?)) -> [Key: Value] {
		let transforms = self.map(transform)
		var result = [Key: Value]()
		
		for (key, value) in transforms {
			if let key = key, let value = value {
				result[key] = value
			}
		}
		
		return result
	}
	
	public var random: (Key, Value)? {
		if self.count <= 0 {
			return nil
		}
		
		let keys = Array(self.keys)
		let values = Array(self.values)
		
		let index = Int(arc4random_uniform(UInt32(self.count)))
		
		return (keys[index], values[index])
	}
}

public func +<Key, Value>(first: [Key: Value]?, second: [Key: Value]?) -> [Key: Value] {
	var result = [Key: Value]()
	
	if let first = first {
		for (key, value) in first {
			result[key] = value
		}
	}
	
	if let second = second {
		for (key, value) in second {
			result[key] = value
		}
	}
	
	return result
}
