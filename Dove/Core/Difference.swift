//
//  Difference.swift
//  Dove
//
//  Created by Connor Haigh on 29/01/2018.
//  Copyright © 2018 Connor Haigh. All rights reserved.
//

import Foundation
import UIKit

public enum Difference {
	case none(index: Int)
	case insertion(index: Int)
	case deletion(index: Int)
	case move(source: Int, destination: Int)
	
	public static func calculate<Element: Equatable>(old: [Element], new: [Element]) -> [Difference] {
		let similarities = new
			.filter({ old.contains($0) })
			.map({ Difference.none(index: new.index(of: $0)!) })
		
		let insertions = new
			.filter({ !old.contains($0) })
			.map({ Difference.insertion(index: new.index(of: $0)!) })
		
		let deletions = old
			.filter({ !new.contains($0) })
			.map({ Difference.deletion(index: old.index(of: $0)!) })
		
		let moves = new
			.filter({ old.contains($0) })
			.filter({ new.index(of: $0) != old.index(of: $0) })
			.map({ Difference.move(source: old.index(of: $0)!, destination: new.index(of: $0)!) })
		
		return similarities + insertions + deletions + moves
	}
}

public extension UICollectionView {
	public func reload(using differences: [Difference]) {
		let indexes = BatchUpdate(from: differences)
		
		self.performBatchUpdates({
			self.insertItems(at: indexes.insertions)
			self.deleteItems(at: indexes.deletions)
			
			for move in indexes.moves {
				self.moveItem(at: move.source, to: move.destination)
			}
		}, completion: nil)
	}
}

public extension UITableView {
	public func reload(using differences: [Difference], with animation: UITableViewRowAnimation) {
		let indexes = BatchUpdate(from: differences)
		
		self.beginUpdates()
		self.insertRows(at: indexes.insertions, with: animation)
		self.deleteRows(at: indexes.deletions, with: animation)
		
		for move in indexes.moves {
			self.moveRow(at: move.source, to: move.destination)
		}
		
		self.endUpdates()
	}
}

private struct BatchUpdate {
	public init(from differences: [Difference]) {
		self.insertions = differences.flatMap({ difference -> IndexPath? in
			guard case let .insertion(index) = difference else {
				return nil
			}
			
			return IndexPath(row: index, section: 0)
		})
		
		self.deletions = differences.flatMap({ difference -> IndexPath? in
			guard case let .deletion(index) = difference else {
				return nil
			}
			
			return IndexPath(row: index, section: 0)
		})
		
		self.moves = differences.flatMap({ difference -> (IndexPath, IndexPath)? in
			guard case let .move(source, destination) = difference else {
				return nil
			}
			
			return (IndexPath(row: source, section: 0), IndexPath(row: destination, section: 0))
		})
	}
	
	public let insertions: [IndexPath]
	public let deletions: [IndexPath]
	public let moves: [(source: IndexPath, destination: IndexPath)]
}
