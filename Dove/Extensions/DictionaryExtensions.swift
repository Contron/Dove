//
//  DictionaryExtensions.swift
//  Dove
//
//  Created by Connor Haigh on 10/08/2016.
//  Copyright © 2016 Connor Haigh. All rights reserved.
//

import Foundation

public extension Dictionary {
	public static func +<Key, Value>(first: [Key: Value], second: [Key: Value]) -> [Key: Value] {
		var results = [Key: Value]()
		
		first.forEach({ results[$0.key] = $0.value })
		second.forEach({ results[$0.key] = $0.value })
		
		return results
	}
	
	public func transform<Key, Value>(_ transform: (Element) -> (Key, Value)) -> [Key: Value] {
		var results = [Key: Value]()
		
		self.map(transform).forEach({ results[$0] = $1 })
		
		return results
	}
	
	public func any(_ predicate: ((key: Key, value: Value)) -> Bool) -> Bool {
		return self.count(predicate) > 0
	}
	
	public func all(_ predicate: ((key: Key, value: Value)) -> Bool) -> Bool {
		return self.count(predicate) >= self.count
	}
	
	public func count(_ predicate: ((key: Key, value: Value)) -> Bool) -> Int {
		return self.reduce(0, { $0 + (predicate($1) ? 1 : 0) })
	}
	
	public func contains(_ key: Key) -> Bool {
		return self[key] != nil
	}
	
	public var urlQuery: String {
		let keys = self.keys.compactMap({ String(describing: $0).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) })
		let values = self.values.compactMap({ String(describing: $0).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) })
		
		let result = zip(keys, values)
			.map({ "\($0)=\($1)" })
			.joined(separator: "&")
		
		return "?\(result)"
	}
	
	public var random: (key: Key, value: Value)? {
		guard self.count > 0 else {
			return nil
		}
		
		let keys = Array(self.keys)
		let values = Array(self.values)
		let index = Int(arc4random_uniform(UInt32(self.count)))
		
		return (keys[index], values[index])
	}
}

public extension Dictionary where Key == String {
	public func instantiate<Target: RawRepresentable>(to target: Target.Type) -> [Target: Value] where Target.RawValue == String {
		var results = [Target: Value]()
		
		for (key, value) in self {
			guard let target = Target.init(rawValue: key) else {
				continue
			}
			
			results[target] = value
		}
		
		return results
	}
}

public func unwrap<Key, Value>(_ dictionary: [Key: Value?]) -> [Key: Value] {
	var results = [Key: Value]()
	
	for (key, value) in dictionary {
		guard let value = value else {
			continue
		}
		
		results[key] = value
	}
	
	return results
}
