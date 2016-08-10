//
//  DictionaryExtensions.swift
//  Dove
//
//  Created by Connor Haigh on 10/08/2016.
//  Copyright © 2016 Connor Haigh. All rights reserved.
//

import Foundation

public extension Dictionary {
	public func collapse<Key: Hashable, Value>(transform: Element -> (Key, Value)) -> [Key: Value] {
		var result = [Key: Value]()
		
		for (key, value) in self.map(transform) {
			result[key] = value
		}
		
		return result
	}
}
