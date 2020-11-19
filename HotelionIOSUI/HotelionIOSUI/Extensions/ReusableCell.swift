//
//  ReusableCell.swift
//  HotelionIOSUI
//
//  Created by Vladyslav Panevnyk on 30.09.2020.
//  Copyright © 2020 Vladyslav Panevnyk. All rights reserved.
//

import UIKit

extension NSObject {
    var className: String {
        return String(describing: type(of: self))
    }

    class var className: String {
        return String(describing: self)
    }
}

// MARK: - Register UITableViewCell
extension UITableView {
    func register<T: UITableViewCell>(cell: T.Type) {
        register(UINib(nibName: cell.className, bundle: Bundle.uiModuleBundle),
                 forCellReuseIdentifier: cell.className)
    }
}

// MARK: - Register UICollectionViewCell
extension UICollectionView {
    func register<T: UICollectionViewCell>(cell: T.Type) {
        register(UINib(nibName: cell.className, bundle: Bundle.uiModuleBundle),
                 forCellWithReuseIdentifier: cell.className)
    }
}

// MARK: - Reusable UITableViewCell
extension UITableView {
    func dequeueReusableCellWithIndexPath<T: UITableViewCell>(_ indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.className, for: indexPath) as? T else {
            fatalError("Couldn't dequeue reusable cell with identifier: \(T.className)")
        }
        return cell
    }

    func dequeueReusableCell<T: UITableViewCell>() -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.className) as? T else {
            fatalError("Couldn't dequeue reusable cell with identifier: \(T.className)")
        }
        return cell
    }
}

// MARK: - Reusable UICollectionViewCell
extension UICollectionView {
    func dequeueReusableCellWithIndexPath<T: UICollectionViewCell>(_ indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.className, for: indexPath) as? T else {
            fatalError("Couldn't dequeue reusable cell with identifier: \(T.className)")
        }
        return cell
    }
}
