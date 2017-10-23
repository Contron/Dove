//
//  Storage.swift
//  Dove
//
//  Created by Connor Haigh on 13/10/2017.
//  Copyright © 2017 Connor Haigh. All rights reserved.
//

import Foundation

public final class Storage {
	private init() {
		
	}
	
	public static func load<Target: Decodable>(from file: String, type: Target.Type) throws -> Target {
		return try decoder.decode(type, from: try Data(contentsOf: Storage.url(for: file)))
	}
	
	public static func save<Target: Encodable>(to file: String, value: Target) throws {
		try encoder.encode(value).write(to: Storage.url(for: file), options: .atomic)
	}
	
	public static func delete(file: String) throws {
		try FileManager.default.removeItem(at: Storage.url(for: file))
	}
	
	private static func url(for file: String) throws -> URL {
		return try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
			.appendingPathComponent(file)
			.appendingPathExtension("json")
	}
}

private let encoder = JSONEncoder()
private let decoder = JSONDecoder()
