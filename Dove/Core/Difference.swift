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
	
	public static func calculate<Element: Equatable>(from old: [Element], to new: [Element]) -> [Difference] {
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
	public func reload(using differences: [Difference], in section: Int) {
		let indexes = Update(from: differences, in: section)
		
		self.performBatchUpdates({
			self.insertItems(at: indexes.insertions)
			self.deleteItems(at: indexes.deletions)
			
			indexes.moves.forEach({ self.moveItem(at: $0.source, to: $0.destination) })
		}, completion: nil)
	}
}

public extension UITableView {
	public func reload(using differences: [Difference], in section: Int, with animation: UITableView.RowAnimation) {
		let indexes = Update(from: differences, in: section)
		
		self.beginUpdates()
		self.insertRows(at: indexes.insertions, with: animation)
		self.deleteRows(at: indexes.deletions, with: animation)
		
		indexes.moves.forEach({ self.moveRow(at: $0.source, to: $0.destination) })
		
		self.endUpdates()
	}
}

private struct Update {
	public init(from differences: [Difference], in section: Int) {
		self.insertions = differences.compactMap({ difference -> IndexPath? in
			guard case let .insertion(index) = difference else {
				return nil
			}
			
			return IndexPath(row: index, section: section)
		})
		
		self.deletions = differences.compactMap({ difference -> IndexPath? in
			guard case let .deletion(index) = difference else {
				return nil
			}
			
			return IndexPath(row: index, section: section)
		})
		
		self.moves = differences.compactMap({ difference -> (IndexPath, IndexPath)? in
			guard case let .move(source, destination) = difference else {
				return nil
			}
			
			return (IndexPath(row: source, section: section), IndexPath(row: destination, section: section))
		})
	}
	
	public let insertions: [IndexPath]
	public let deletions: [IndexPath]
	public let moves: [(source: IndexPath, destination: IndexPath)]
}
