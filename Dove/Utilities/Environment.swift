//
//  Environment.swift
//  Dove
//
//  Created by Connor Haigh on 04/10/2016.
//  Copyright © 2016 Connor Haigh. All rights reserved.
//

import Foundation

public final class Environment {
	public enum Mode {
		case debug
		case release
	}
	
	private init() {
		
	}
	
	public static var mode: Mode {
		#if DEBUG
			return .debug
		#else
			return .release
		#endif
	}
	
	public static var version: String? {
		return Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
	}
	
	public static var build: String? {
		return Bundle.main.infoDictionary?["CFBundleVersion"] as? String
	}
	
	public static var identifier: String? {
		return UIDevice.current.identifierForVendor?.uuidString
			.lowercased()
			.replacingOccurrences(of: "-", with: String())
	}
	
	public static var buildDate: Date? {
		guard
			let url = Bundle.main.url(forResource: "Info", withExtension: "plist"),
			let attributes = try? FileManager.default.attributesOfItem(atPath: url.path),
			let date = attributes[.creationDate] as? Date
		else {
			return nil
		}
		
		return date
	}
	
	public static var compilationDate: Date? {
		guard
			let name = Bundle.main.infoDictionary?["CFBundleName"] as? String,
			let url = Bundle.main.url(forResource: name, withExtension: nil),
			let attributes = try? FileManager.default.attributesOfItem(atPath: url.path),
			let date = attributes[.creationDate] as? Date
		else {
			return nil
		}
		
		return date
	}
}
