//
//  Debug.swift
//  Dove
//
//  Created by Connor Haigh on 09/08/2016.
//  Copyright © 2016 Connor Haigh. All rights reserved.
//

import Foundation

public func debug(_ object: Any) {
	#if DEBUG
		let formatter = DateFormatter()
		formatter.dateFormat = "HH:mm:ss"
		
		let date = formatter.string(from: Date())
		
		let type = String(describing: type(of: object))
		let object = String(describing: object)
		
		print("[\(date) \(type)] \(object)")
	#endif
}
