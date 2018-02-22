//
//  Debug.swift
//  Dove
//
//  Created by Connor Haigh on 09/08/2016.
//  Copyright © 2016 Connor Haigh. All rights reserved.
//

import Foundation

public func debug(_ object: Any, file: String = #file) {
	#if DEBUG
        let date = formatter.string(from: .now)
        
        let file = URL(string: file)?.deletingPathExtension().lastPathComponent ?? "Unknown"
        let object = String(describing: object)
        
        print("[\(date) \(file)] \(object)")
    #endif
}

public func inspect(_ value: Any) -> String {
	switch value {
	case let value as [AnyHashable: Any]:
		return "{\(value.map({ "\(inspect($0)): \(inspect($1))" }).joined(separator: ", "))}"
	case let value as [Any]:
		return "[\(value.map({ inspect($0) }).joined(separator: ", "))]"
	case let value as String:
		return "\"\(value)\""
	case let value as Bool:
		return value ? "true" : "false"
	default:
		return String(describing: value)
	}
}

private let formatter: DateFormatter = {
	let formatter = DateFormatter()
	formatter.dateFormat = "HH:mm:ss"
	
	return formatter
}()
