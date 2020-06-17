//
//  Data.swift
//  Memorize
//
//  Created by Andrew Marmion on 17/06/2020.
//  Copyright © 2020 Andrew Marmion. All rights reserved.
//

import Foundation

extension Data {
    // just a simple converter from a Data to a String
    var utf8: String? { String(data: self, encoding: .utf8 ) }
}

extension Data {

    /// Creates a pretty printed json representation of the string
    var prettyPrinted: NSString? {
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
            let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted, .sortedKeys]),
            let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else { return nil }

        return prettyPrintedString
    }
}
