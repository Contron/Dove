//
//  DictionaryExtensions.swift
//  Dove
//
//  Created by Connor Haigh on 10/08/2016.
//  Copyright © 2016 Connor Haigh. All rights reserved.
//

import Foundation

public extension Dictionary where Key: Hashable {
	public func transform<Key, Value>(_ transform: (Element) -> (Key, Value)) -> [Key: Value] {
		var result = [Key: Value]()
		
		self.map(transform).forEach({ result[$0] = $1 })
		
		return result
	}
}

public extension Dictionary {
	public func any(_ predicate: (Key, Value) -> Bool) -> Bool {
		return self.count(predicate) > 0
	}
	
	public func all(_ predicate: (Key, Value) -> Bool) -> Bool {
		return self.count(predicate) >= self.count
	}
	
	public func count(_ predicate: (Key, Value) -> Bool) -> Int {
		var count = 0
		
		for (key, value) in self {
			if predicate(key, value) {
				count += 1
			}
		}
		
		return count
	}
	
	public var urlQuery: String {
		let keys = self.keys.flatMap({ String(describing: $0).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) })
		let values = self.values.flatMap({ String(describing: $0).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) })
		
		let result = zip(keys, values)
			.map({ "\($0)=\($1)" })
			.joined(separator: "&")
		
		return "?\(result)"
	}
	
	public var random: (Key, Value)? {
		guard self.count > 0 else {
			return nil
		}
		
		let keys = Array(self.keys)
		let values = Array(self.values)
		let index = Int(arc4random_uniform(UInt32(self.count)))
		
		return (keys[index], values[index])
	}
}

public func unwrap<Key, Value>(_ dictionary: [Key: Value?]) -> [Key: Value] {
	var result = [Key: Value]()
	
	for (key, value) in dictionary {
		if let value = value {
			result[key] = value
		}
	}
	
	return result
}

public func +<Key, Value>(first: [Key: Value], second: [Key: Value]) -> [Key: Value] {
	var result = [Key: Value]()
	
	first.forEach({ result[$0.key] = $0.value })
	second.forEach({ result[$0.key] = $0.value })
	
	return result
}
