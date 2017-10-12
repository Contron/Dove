//
//  UserDefaultsExtensions.swift
//  Dove
//
//  Created by Connor Haigh on 11/10/2017.
//  Copyright © 2017 Connor Haigh. All rights reserved.
//

import Foundation

public extension UserDefaults {
	public func get<Target: Decodable>(decodable key: String, _ type: Target.Type) -> Target? {
		guard let data = self.data(forKey: key), let instance = try? decoder.decode(type, from: data) else {
			return nil
		}
		
		return instance
	}
	
	public func set<Type: Encodable>(encodable: Type, key: String) {
		guard let data = try? encoder.encode(encodable) else {
			return
		}
		
		self.set(data, forKey: key)
	}
}

private let encoder = PropertyListEncoder()
private let decoder = PropertyListDecoder()
