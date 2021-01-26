//
//  ConfigurableCell.swift
//  Schoolia
//
//  Created by Mohamed Shaat on 8/20/20.
//  Copyright © 2020 Schoolia. All rights reserved.
//

import Foundation

protocol ConfigurableCell {
    associatedtype DataType
    func configure(data: DataType)
    static var reuseIdentifier: String { get }
    static func getCellIdentifier() -> String
}

extension ConfigurableCell {
    
    static var reuseIdentifier: String { return String(describing: Self.self) }
    static func getCellIdentifier() -> String {
        return reuseIdentifier
    }
    
}
