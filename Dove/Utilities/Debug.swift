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

private let formatter: DateFormatter = {
	let formatter = DateFormatter()
	formatter.dateFormat = "HH:mm:ss"
	
	return formatter
}()
