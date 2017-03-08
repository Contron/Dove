//
//  Environment.swift
//  Dove
//
//  Created by Connor Haigh on 04/10/2016.
//  Copyright © 2016 Connor Haigh. All rights reserved.
//

import Foundation

public class Environment {
	public enum Platform {
		case phone
		case tablet
		case television
		case vehicle
	}
	
	public enum Orientation {
		case portrait
		case landscape
	}
	
	public enum Mode {
		case debug
		case release
	}
	
	public static var platform: Platform {
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
	
	public static var orientation: Orientation {
		switch UIDevice.current.orientation {
		case .landscapeLeft, .landscapeRight:
			return .landscape
		default:
			return .portrait
		}
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
			.replacingOccurrences(of: "-", with: "")
	}
}
