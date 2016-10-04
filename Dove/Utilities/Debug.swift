//
//  Debug.swift
//  Dove
//
//  Created by Connor Haigh on 09/08/2016.
//  Copyright © 2016 Connor Haigh. All rights reserved.
//

import Foundation

public func debug(_ object: Any, _ file: String = #file) {
	#if DEBUG
		let formatter = DateFormatter()
		formatter.dateFormat = "HH:mm:ss"
		
		let date = "Now"
		
		let file = URL(string: file)?.lastPathComponent ?? "Unknown"
		let object = String(describing: object)
		
		print("[\(date) \(file)] \(object)")
	#endif
}
