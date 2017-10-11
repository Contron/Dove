//
//  UserDefaultsExtensions.swift
//  Dove
//
//  Created by Connor Haigh on 11/10/2017.
//  Copyright © 2017 Connor Haigh. All rights reserved.
//

import Foundation

public extension UserDefaults {
	public func set<Type: Encodable>(_ encodable: Type, forKey key: String) {
		guard let data = try? PropertyListEncoder().encode(encodable) else {
			return
		}
		
		self.set(data, forKey: key)
	}
	
	public func decodable<Target: Decodable>(forKey key: String, _ type: Target.Type) -> Target? {
		guard let data = self.data(forKey: key), let instance = try? PropertyListDecoder().decode(type, from: data) else {
			return nil
		}
		
		return instance
	}
}
