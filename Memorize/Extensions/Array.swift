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
