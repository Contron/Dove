//
//  ArrayExtensions.swift
//  Dove
//
//  Created by Connor Haigh on 02/06/2016.
//  Copyright © 2016 Connor Haigh. All rights reserved.
//

import Foundation

public extension Array where Element: Equatable {
	public func allEqual<T: Equatable>(predicate: Element -> T) -> Bool {
		if let first = self.first {
			let first = predicate(first)
			
			for element in self {
				let element = predicate(element)
				
				if element != first {
					return false
				}
			}
		}
		
		return true
	}
	
	public func distinct() -> [Element] {
		var results = [Element]()
		
		for element in self {
			if !results.contains(element) {
				results.append(element)
			}
		}
		
		return results
	}
	
	public mutating func remove(element: Element) {
		if let index = self.indexOf(element) {
			self.removeAtIndex(index)
		}
	}
	
	public var random: Element? {
		if self.count <= 0 {
			return nil
		}
		
		return self[Int(arc4random_uniform(UInt32(self.count)))]
	}
}

public extension Array {
	public func any(predicate: Element -> Bool) -> Bool {
		return self.count(predicate) > 0
	}
	
	public func all(predicate: Element -> Bool) -> Bool {
		return self.count(predicate) == self.count
	}
	
	public func count(predicate: Element -> Bool) -> Int {
		var count = 0
		
		for element in self {
			if predicate(element) {
				count += 1
			}
		}
		
		return count
	}
}
