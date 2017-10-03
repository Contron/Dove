//
//  Dove.swift
//  Dove
//
//  Created by Connor Haigh on 03/06/2016.
//  Copyright © 2016 Connor Haigh. All rights reserved.
//

import Foundation

public typealias ActionBlock = () -> ()
public typealias ResultBlock = (Bool) -> ()

public typealias KeyValues = [String: Any]

public let bundleIdentifier = Bundle.main.bundleIdentifier ?? Bundle.main.infoDictionary?["CFBundleIdentifier"] as? String ?? "application"

public let animationConstant = 0.3
public let shorterAnimationConstant = animationConstant / 2
public let longerAnimationConstant = animationConstant * 2

public let springDamping = 0.5
public let springInitialVelocity = 0.1
