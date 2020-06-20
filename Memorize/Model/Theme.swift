//
//  Theme.swift
//  Memorize
//
//  Created by Andrew Marmion on 19/06/2020.
//  Copyright © 2020 Andrew Marmion. All rights reserved.
//

import SwiftUI

struct Theme: Codable, Identifiable, Equatable, Hashable {
    typealias Emoji = String

    let id: UUID
    let name: String
    let emoji: [Emoji]
    let numberOfPairs: Int
    // changed color to be an Int as that means we can use system colors and they will respond nicely to dark/light mode
    let color: Int
    let previousEmoji: [Emoji]

    init(id: UUID = UUID(), name: String, emoji: [Emoji], numberOfPairs: Int, color: Int, previousEmoji: [Emoji] = []) {
        self.id = id
        self.name = name
        self.emoji = emoji
        self.numberOfPairs = numberOfPairs
        self.color = color
        self.previousEmoji = previousEmoji
    }

    init() {
        self.id = UUID()
        self.name = ""
        self.emoji = [String]()
        self.numberOfPairs = 2
        self.color = 0
        self .previousEmoji = [String]()
    }

    init?(json: Data?) {
        if let data = json, let theme = try? JSONDecoder().decode(Theme.self, from: data) {
            self = theme
        } else {
            return nil
        }
    }

    var cardColor: Color {
        Color(colors[color])
    }

    var json: Data? {
        try? JSONEncoder().encode(self)
    }

    static let themes: [Theme] = [
        Theme(name: "Halloween",
              emoji: ["🎃", "👻", "🕷", "🕸", "🧙‍♀️", "💀", "🦇"],
              numberOfPairs: 6,
              color: 0),

        Theme(name: "Flags",
              emoji: ["🏴󠁧󠁢󠁳󠁣󠁴󠁿", "🏴󠁧󠁢󠁥󠁮󠁧󠁿", "🇮🇪", "🏴󠁧󠁢󠁷󠁬󠁳󠁿", "🇫🇷", "🇮🇹", "🇩🇪", "🇧🇪", "🇱🇺", "🇪🇺"],
              numberOfPairs: 10,
              color: 1),

        Theme(name: "Smileys",
              emoji: ["😀", "😍", "😝", "😎", "🤩", "🤢", "💩", "🤑", "🤕", "🥴", "🤥", "🤬", "🤯", "🥶", "🥺", "😈"],
              numberOfPairs: 8,
              color: 2),

        Theme(name: "Food",
              emoji: ["🌭", "🍔", "🌮", "🍟", "🍕", "🍣", "🥟", "🍿", "🍩", "🍦"],
              numberOfPairs: 8,
              color: 3),

        Theme(name: "Sport",
              emoji: ["⚽️", "🏀", "🏈", "⚾️", "🥎", "🎾", "🏐", "🏉", "🎱", "🏓", "🏒", "🏑", "🥋", "🥊", "🤿", "⛳️"],
              numberOfPairs: 8,
              color: 4),

        Theme(name: "Animals",
              emoji: ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼", "🐨", "🐯", "🦁", "🐮", "🐷", "🐸", "🐵", "🦄"],
              numberOfPairs: 8,
              color: 5)
    ]

}


