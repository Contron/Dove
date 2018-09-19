//
//  SequenceExtensions.swift
//  Dove
//
//  Created by Connor Haigh on 18/09/2018.
//  Copyright © 2018 Connor Haigh. All rights reserved.
//

import Foundation

public extension Sequence {
	public func count(where predicate: (Element) throws -> Bool) rethrows -> Int {
		var count = 0
		
		for element in self where try predicate(element) {
			count += 1
		}
		
		return count
	}
	
	public func project<Key, Value>(_ transform: (Element) throws -> (key: Key, value: Value)) rethrows -> [Key: Value] {
		return [Key: Value](uniqueKeysWithValues: try self.map(transform))
	}
	
	public func group<Key>(by predicate: (Element) throws -> Key) rethrows -> [Key: [Element]] {
		return try [Key: [Element]](grouping: self, by: predicate)
	}
}
