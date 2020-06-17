//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Andrew Marmion on 20/05/2020.
//  Copyright © 2020 Andrew Marmion. All rights reserved.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    @Published private var model: MemoryGame<String>
    
    @Published var gameComplete: Bool = false
    
    private(set) var theme: Theme
    
    init() {
        let (game, theme) = EmojiMemoryGame.createMemoryGame()
        self.model = game
        self.theme = theme
    }
    
    private static func createMemoryGame() -> (game: MemoryGame<String>, theme: Theme) {
        let theme: Theme = themes.randomElement()!
        print("Theme: ", theme.json?.prettyPrinted ?? "unable to get json theme")
        return (game: MemoryGame<String>(numberOfPairsOfCards: theme.emoji.count) { pairIndex in theme.emoji[pairIndex] }, theme: theme)
    }
    
    // MARK: - Access to the Model
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    
    var score: Int { model.score }
    
    // MARK: - Intent(s)
    
    
    /// Chooses a card
    /// - Parameter card: the card that we have tapped
    func choose(card: MemoryGame<String>.Card) {
        model.choose(card: card)
        
        // updare our game complete status
        gameComplete = model.gameComplete
    }
    
    
    /// This creates a new game
    func newGame() {
        let (game, theme) = EmojiMemoryGame.createMemoryGame()
        self.model = game
        self.theme = theme
        self.gameComplete = false
    }
    
    struct Theme: Codable {
        typealias Emoji = String
        
        let name: String
        let emoji: [Emoji]
        let color: UIColor.RGB

        var cardColor: Color {
            Color(color)
        }

        var json: Data? {
            try? JSONEncoder().encode(self)
        }
    }
    
    private static let themes: [Theme] = [
        Theme(name: "Halloween",
              emoji: ["🎃", "👻", "🕷", "🕸", "🧙‍♀️", "💀", "🦇"],
              color: .init(red: 244 / 255, green: 142 / 255, blue: 40 / 255, alpha: 1)),

        Theme(name: "Flags",
              emoji: ["🏴󠁧󠁢󠁳󠁣󠁴󠁿", "🏴󠁧󠁢󠁥󠁮󠁧󠁿", "🇮🇪", "🏴󠁧󠁢󠁷󠁬󠁳󠁿", "🇫🇷", "🇮🇹", "🇩🇪", "🇧🇪", "🇱🇺", "🇪🇺"],
              color: .init(red: 27 / 255, green: 181 / 255, blue: 27 / 255, alpha: 1)),

        Theme(name: "Smileys",
              emoji: ["😀", "😍", "😝", "😎", "🤩", "🤢", "💩", "🤑", "🤕", "🥴", "🤥", "🤬", "🤯", "🥶", "🥺", "😈"],
              color: .init(red: 244 / 255, green: 142 / 255, blue: 40 / 255, alpha: 1)),

        Theme(name: "Food",
              emoji: ["🌭", "🍔", "🌮", "🍟", "🍕", "🍣", "🥟", "🍿", "🍩", "🍦"],
              color: .init(red: 245 / 255, green: 241 / 255, blue: 15 / 255, alpha: 1)),
        
        Theme(name: "Sport",
              emoji: ["⚽️", "🏀", "🏈", "⚾️", "🥎", "🎾", "🏐", "🏉", "🎱", "🏓", "🏒", "🏑", "🥋", "🥊", "🤿", "⛳️"],
              color: .init(red: 246 / 255, green: 141 / 255, blue: 232 / 255, alpha: 1)),
        
        Theme(name: "Animals",
              emoji: ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼", "🐨", "🐯", "🦁", "🐮", "🐷", "🐸", "🐵", "🦄"],
              color: .init(red: 247 / 255, green: 27 / 255, blue: 27 / 255, alpha: 1))
    ]
}


