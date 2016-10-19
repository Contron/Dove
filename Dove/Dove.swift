//
//  Dove.swift
//  Dove
//
//  Created by Connor Haigh on 03/06/2016.
//  Copyright © 2016 Connor Haigh. All rights reserved.
//

import Foundation

public typealias ActionBlock = (Void) -> Void
public typealias BoolBlock = (Void) -> Bool
public typealias IntBlock = (Void) -> Int
public typealias StringBlock = (Void) -> String

public typealias KeyValues = [String: Any]

public let bundleIdentifier = Bundle.main.bundleIdentifier ?? Bundle.main.infoDictionary?["CFBundleIdentifier"] as? String ?? "application"

public let animationConstant = 0.3
public let shorterAnimationConstant = animationConstant / 2
public let longerAnimationConstant = animationConstant * 2
