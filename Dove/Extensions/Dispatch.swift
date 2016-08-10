//
//  Dispatch.swift
//  Dove
//
//  Created by Connor Haigh on 10/08/2016.
//  Copyright © 2016 Connor Haigh. All rights reserved.
//

import Foundation

public class Dispatch {
	public static func main(block: ActionBlock) {
		dispatch_async(dispatch_get_main_queue(), block)
	}
	
	public static func delay(delay: Double, _ block: ActionBlock) {
		dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(delay * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), block)
	}
	
	public static func background(block: ActionBlock) {
		dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), block)
	}
}
