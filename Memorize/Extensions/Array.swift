//
//  Array.swift
//  Memorize
//
//  Created by Andrew Marmion on 01/06/2020.
//  Copyright © 2020 Andrew Marmion. All rights reserved.
//

import Foundation

extension Array {
    var only: Element? {
        self.count == 1 ? self.first : nil
    }
}

extension Array where Element: Equatable {
    @discardableResult
    mutating func setInsert(_ element: Element) -> Bool {
        if !self.contains(where: { $0 == element }) {
            self.append(element)
            return true
        }
        return false
    }

    mutating func setRemove(_ element: Element) {
        self.removeAll(where: { $0 == element })
    }
}
