//
//  ArrayExtensions.swift
//  Dove
//
//  Created by Connor Haigh on 02/06/2016.
//  Copyright © 2016 Connor Haigh. All rights reserved.
//

import Foundation

public extension Array where Element: Equatable {
	public mutating func remove(_ element: Element) {
		guard let index = self.index(of: element) else {
			return
		}
		
		self.remove(at: index)
	}
	
	public func all<T: Equatable>(equal predicate: (Element) -> T) -> Bool {
		guard let first = self.first else {
			return true
		}
		
		let template = predicate(first)
		
		for element in self {
			guard predicate(element) == template else {
				return false
			}
		}
		
		return true
	}
	
	public func contains(_ array: [Element]) -> Bool {
		for element in array {
			guard self.contains(element) else {
				return false
			}
		}
		
		return true
	}
	
	public func distinct() -> [Element] {
		var results = [Element]()
		
		for element in self {
			guard !results.contains(element) else {
				continue
			}
			
			results.append(element)
		}
		
		return results
	}
}

public extension Array {
	public mutating func remove(_ predicate: (Element) -> Bool) {
		for index in stride(from: self.count - 1, through: 0, by: -1) {
			guard predicate(self[index]) else {
				continue
			}
			
			self.remove(at: index)
		}
	}
	
	public mutating func shuffle() {
		guard self.count > 1 else {
			return
		}
		
		for index in stride(from: 0, through: self.count - 1, by: 1) {
			let next = Int(arc4random_uniform(UInt32(self.count - index))) + index
			
			guard next != index else {
				continue
			}
			
			self.swapAt(index, next)
		}
	}
	
	public func transform<Key: Hashable, Value>(_ transform: (Element) -> (Key, Value)) -> [Key: Value] {
		var results = [Key: Value]()
		
		self.map(transform).forEach({ results[$0] = $1 })
		
		return results
	}
	
	public func group<Key: Hashable>(_ transform: (Element) -> Key) -> [Key: Element] {
		var results = [Key: Element]()
		
		self.forEach({ results[transform($0)] = $0 })
		
		return results
	}
	
	public func all(_ predicate: (Element) -> Bool) -> Bool {
		return self.count(predicate) >= self.count
	}
	
	public func any(_ predicate: (Element) -> Bool) -> Bool {
		return self.count(predicate) > 0
	}
	
	public func count(_ predicate: (Element) -> Bool) -> Int {
		return self.reduce(0, { $0 + (predicate($1) ? 1 : 0) })
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
		guard let element = element else {
			continue
		}
		
		results.append(element)
	}
	
	return results
}
