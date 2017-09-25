//
//  ArrayExtensions.swift
//  Dove
//
//  Created by Connor Haigh on 02/06/2016.
//  Copyright © 2016 Connor Haigh. All rights reserved.
//

import Foundation

public extension Array where Element: Equatable {
	public func all<T: Equatable>(equal predicate: (Element) -> T) -> Bool {
		guard let first = self.first else {
			return true
		}
		
		let template = predicate(first)
		
		for element in self {
			if predicate(element) != template {
				return false
			}
		}
		
		return true
	}
	
	
	public func contains(_ array: [Element]) -> Bool {
		for element in array {
			if !self.contains(element) {
				return false
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
	
	public mutating func remove(_ element: Element) {
		if let index = self.index(of: element) {
			self.remove(at: index)
		}
	}
}

public extension Array {
	public mutating func remove(_ predicate: (Element) -> Bool) {
		for (index, element) in self.enumerated().reversed() {
			if predicate(element) {
				self.remove(at: index)
			}
		}
	}
	
	public func transform<Key: Hashable, Value>(_ transform: (Element) -> (Key, Value)) -> [Key: Value] {
		var result = [Key: Value]()
		
		self.map(transform).forEach({ result[$0] = $1 })
		
		return result
	}
	
	public func group<Key: Hashable>(_ transform: (Element) -> Key) -> [Key: Element] {
		var result = [Key: Element]()
		
		self.forEach({ result[transform($0)] = $0 })
		
		return result
	}
	
	public func any(_ predicate: (Element) -> Bool) -> Bool {
		return self.count(predicate) > 0
	}
	
	public func all(_ predicate: (Element) -> Bool) -> Bool {
		return self.count(predicate) >= self.count
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
	
	public func shuffle() -> [Element] {
		guard self.count > 1 else {
			return self
		}
		
		var results = Array(self)
		
		for index in 0..<self.count - 1 {
			let next = Int(arc4random_uniform(UInt32(self.count - index))) + index
			
			if next != index {
				results.swapAt(index, next)
			}
		}
		
		return results
	}
	
	public var random: Element? {
		guard self.count > 0 else {
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
