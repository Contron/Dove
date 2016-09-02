//
//  Dove.swift
//  Dove
//
//  Created by Connor Haigh on 03/06/2016.
//  Copyright © 2016 Connor Haigh. All rights reserved.
//

import Foundation

public typealias ActionBlock = Void -> Void

public let bundleIdentifier = NSBundle.mainBundle().bundleIdentifier ?? NSBundle.mainBundle().infoDictionary?["CFBundleIdentifier"] ?? "app"
