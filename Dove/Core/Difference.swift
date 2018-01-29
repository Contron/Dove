//
//  Difference.swift
//  Dove
//
//  Created by Connor Haigh on 29/01/2018.
//  Copyright © 2018 Connor Haigh. All rights reserved.
//

import Foundation
import UIKit

public struct Difference {
	public static func calculate<Element: Equatable>(old: [Element], new: [Element]) -> Difference {
		let insertions = new.filter({ !old.contains($0) }).flatMap({ new.index(of: $0) })
		let deletions = old.filter({ !new.contains($0) }).flatMap({ old.index(of: $0) })
		let similarities = old.filter({ new.contains($0) }).flatMap({ old.index(of: $0) })
		
		return Difference(insertions: insertions, deletions: deletions, similarities: similarities)
	}
	
	private init(insertions: [Int], deletions: [Int], similarities: [Int]) {
		self.insertions = insertions
		self.deletions = deletions
		self.similarities = similarities
	}
	
	let insertions: [Int]
	let deletions: [Int]
	let similarities: [Int]
}

public extension UITableView {
	public func reload(using difference: Difference, with animation: UITableViewRowAnimation) {
		self.beginUpdates()
		self.insertRows(at: project(indexes: difference.insertions), with: animation)
		self.deleteRows(at: project(indexes: difference.deletions), with: animation)
		self.endUpdates()
	}
}

public extension UICollectionView {
	public func reload(using difference: Difference) {
		self.performBatchUpdates({
			self.insertItems(at: project(indexes: difference.insertions))
			self.deleteItems(at: project(indexes: difference.deletions))
		}, completion: nil)
	}
}

private func project(indexes: [Int]) -> [IndexPath] {
	return indexes.map({ IndexPath(row: $0, section: 0) })
}
