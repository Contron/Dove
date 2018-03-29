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
		for (index, element) in self.enumerated().reversed() {
			guard predicate(element) else {
				continue
			}
			
			self.remove(at: index)
		}
	}
	
	public func shuffle() -> [Element] {
		guard self.count > 1 else {
			return self
		}
		
		var results = Array(self)
		
		for index in 0..<results.count - 1 {
			let next = Int(arc4random_uniform(UInt32(results.count - index))) + index
			
			guard next != index else {
				continue
			}
			
			results.swapAt(index, next)
		}
		
		return results
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
	
	public func any(_ predicate: (Element) -> Bool) -> Bool {
		return self.count(predicate) > 0
	}
	
	public func all(_ predicate: (Element) -> Bool) -> Bool {
		return self.count(predicate) >= self.count
	}
	
	public func count(_ predicate: (Element) -> Bool) -> Int {
		var count = 0
		
		for element in self {
			guard predicate(element) else {
				continue
			}
			
			count += 1
		}
		
		return count
	}
	
	public var random: Element? {
		guard self.count > 0 else {
			return nil
		}
		
		return self[Int(arc4random_uniform(UInt32(self.count)))]
	}
}

public extension Array where Element == String {
	public func instantiate<Target: RawRepresentable>(to target: Target.Type) -> [Target] where Target.RawValue == String {
		var results = [Target]()
		
		for value in self {
			guard let target = Target.init(rawValue: value) else {
				continue
			}
			
			results.append(target)
		}
		
		return results
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
