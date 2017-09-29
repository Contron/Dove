//
//  DictionaryExtensions.swift
//  Dove
//
//  Created by Connor Haigh on 10/08/2016.
//  Copyright © 2016 Connor Haigh. All rights reserved.
//

import Foundation

public extension Dictionary {
	public func transform<Key, Value>(_ transform: (Element) -> (Key, Value)) -> [Key: Value] {
		var result = [Key: Value]()
		
		self.map(transform).forEach({ result[$0] = $1 })
		
		return result
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
		let keys = self.keys.flatMap({ String(describing: $0).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) })
		let values = self.values.flatMap({ String(describing: $0).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) })
		
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

public func instantiate<Target: RawRepresentable, Value>(_ dictionary: [String: Value], _ type: Target.Type) -> [Target: Value] where Target.RawValue == String {
	var result = [Target: Value]()
	
	for (key, value) in dictionary {
		if let target = type.init(rawValue: key) {
			result[target] = value
		}
	}
	
	return result
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
