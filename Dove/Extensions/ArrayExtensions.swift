//
//  ArrayExtensions.swift
//  Dove
//
//  Created by Connor Haigh on 02/06/2016.
//  Copyright © 2016 Connor Haigh. All rights reserved.
//

import Foundation

public extension Array where Element: Equatable {
	public func allEqual<T: Equatable>(_ predicate: (Element) -> T) -> Bool {
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
	
	public func shuffle() -> [Element] {
		if self.count < 2 {
			return self
		}
		
		var results = Array(self)
		
		for index in 0..<self.count - 1 {
			let next = Int(arc4random_uniform(UInt32(self.count - index))) + index
			
			if next != index {
				swap(&results[index], &results[next])
			}
		}
		
		return results
	}

	public mutating func remove(element: Element) {
		if let index = self.index(of: element) {
			self.remove(at: index)
		}
	}
}

public extension Array {
	public func any(_ predicate: (Element) -> Bool) -> Bool {
		return self.count(predicate) > 0
	}
	
	public func all(_ predicate: (Element) -> Bool) -> Bool {
		return self.count(predicate) == self.count
	}
	
	public func count(_ predicate: (Element) -> Bool) -> Int {
		var count = 0
		
		for element in self {
			if predicate(element) {
				count += 1
			}
		}
		
		return count
	}
	
	public mutating func remove(_ predicate: (Element) -> Bool) {
		for (index, element) in self.enumerated() {
			if predicate(element) {
				self.remove(at: index)
			}
		}
	}
	
	public var random: Element? {
		if self.count <= 0 {
			return nil
		}
		
		return self[Int(arc4random_uniform(UInt32(self.count)))]
	}
}

public func unwrap<Element>(_ array: [Element?]) -> [Element] {
	var results = [Element]()
	
	for element in array {
		if let element = element {
			results.append(element)
		}
	}
	
	return results
}
