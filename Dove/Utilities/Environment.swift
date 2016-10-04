//
//  Environment.swift
//  Dove
//
//  Created by Connor Haigh on 04/10/2016.
//  Copyright © 2016 Connor Haigh. All rights reserved.
//

import Foundation

class Environment {
	enum Platform {
		case phone
		case tablet
		case television
		case vehicle
	}
	
	enum Mode {
		case debug
		case release
	}
	
	static var platform: Platform {
		switch UIDevice.current.userInterfaceIdiom {
		case .pad:
			return .tablet
		case .tv:
			return .television
		case .carPlay:
			return .vehicle
		default:
			return .phone
		}
	}
	
	static var mode: Mode {
		#if DEBUG
			return .debug
		#else
			return .release
		#endif
	}
	
	static var version: String? {
		return Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
	}
	
	static var build: String? {
		return Bundle.main.infoDictionary?["CFBundleVersion"] as? String
	}
	
	static var identifier: String? {
		return UIDevice.current.identifierForVendor?.uuidString
			.lowercased()
			.replacingOccurrences(of: "-", with: "")
	}
}
