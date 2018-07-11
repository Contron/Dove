//
//  UserDefaultsExtensions.swift
//  Dove
//
//  Created by Connor Haigh on 09/07/2018.
//  Copyright © 2018 Connor Haigh. All rights reserved.
//

import Foundation

public extension UserDefaults {
	public struct Key: RawRepresentable, Equatable, Hashable {
		public init(rawValue: String) {
			self.rawValue = rawValue
		}
		
		public init(_ rawValue: String) {
			self.rawValue = rawValue
		}
		
		public let rawValue: String
	}
	
	public func object(forKey key: Key) -> Any? {
		return self.object(forKey: key.rawValue)
	}
	
	public func set(_ value: Any?, forKey key: Key) {
		self.set(value, forKey: key.rawValue)
	}
	
	public func removeObject(forKey key: Key) {
		self.removeObject(forKey: key.rawValue)
	}
	
	public func objectIsForced(forKey key: Key) -> Bool {
		return self.objectIsForced(forKey: key.rawValue)
	}
	
	public func objectIsForced(forKey key: Key, inDomain domain: String) -> Bool {
		return self.objectIsForced(forKey: key.rawValue, inDomain: domain)
	}
	
	public func register(defaults: [Key: Any]) {
		self.register(defaults: defaults.transform({ ($0.rawValue, $1) }))
	}
}
