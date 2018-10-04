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
	
	public func project<T, V>(_ transform: (Element) throws -> (key: T, value: V)) rethrows -> [T: V] {
		return [T: V](uniqueKeysWithValues: try self.map(transform))
	}
	
	public func group<T>(by predicate: (Element) throws -> T) rethrows -> [T: [Element]] {
		return try [T: [Element]](grouping: self, by: predicate)
	}
}
