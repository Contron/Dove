//
//  FileManagerExtensions.swift
//  Dove
//
//  Created by Connor Haigh on 07/12/2018.
//  Copyright © 2018 Connor Haigh. All rights reserved.
//

import Foundation

public extension FileManager {
	public struct Key: RawRepresentable, Equatable, Hashable {
		public init(rawValue: String) {
			self.rawValue = rawValue
		}
		
		public init(_ rawValue: String) {
			self.rawValue = rawValue
		}
		
		public let rawValue: String
	}
	
	public func extendedAttribute(for url: URL, key: FileManager.Key) -> String? {
		return url.withUnsafeFileSystemRepresentation({ pointer in
			let length = getxattr(pointer, key.rawValue, nil, 0, 0, 0)
			
			guard length != -1 else {
				return nil
			}
			
			var data = Data(count: length)
			
			let result = data.withUnsafeMutableBytes({ bytes in
				getxattr(pointer, key.rawValue, bytes, length, 0, 0)
			})
			
			guard result != -1 else {
				return nil
			}
			
			return String(data: data, encoding: .utf8)
		})
	}
	
	public func setExtendedAttribute(for url: URL, key: FileManager.Key, value: String) {
		_ = url.withUnsafeFileSystemRepresentation({ pointer in
			guard let data = value.data(using: .utf8) else {
				return
			}
			
			_ = data.withUnsafeBytes({ bytes in
				setxattr(pointer, key.rawValue, bytes, data.count, 0, 0)
			})
		})
	}
	
	public func removeExtendedAttribute(for url: URL, key: FileManager.Key) {
		_ = url.withUnsafeFileSystemRepresentation({ pointer in
			removexattr(pointer, key.rawValue, 0)
		})
	}
}
