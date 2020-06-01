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
    
    static func createMemoryGame() -> (game: MemoryGame<String>, theme: Theme) {
        let theme: Theme = themes.randomElement()!
        let numberOfPairsOfCards: Int = Int.random(in: 2..<theme.emoji.count)
        return (game: MemoryGame<String>(numberOfPairsOfCards: numberOfPairsOfCards) { pairIndex in theme.emoji[pairIndex] }, theme: theme)
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
    
    struct Theme {
        typealias Emoji = String
        
        let name: String
        let emoji: [Emoji]
        let cardColor: Color
    }
    
    private static let themes: [Theme] = [
        Theme(name: "Halloween",
              emoji: ["🎃", "👻", "🕷", "🕸", "🧙‍♀️", "💀", "🦇"],
              cardColor: .orange),

        Theme(name: "Flags",
              emoji: ["🏴󠁧󠁢󠁳󠁣󠁴󠁿", "🏴󠁧󠁢󠁥󠁮󠁧󠁿", "🇮🇪", "🏴󠁧󠁢󠁷󠁬󠁳󠁿", "🇫🇷", "🇮🇹", "🇩🇪", "🇧🇪", "🇱🇺", "🇪🇺"],
              cardColor: .green),

        Theme(name: "Smileys",
              emoji: ["😀", "😍", "😝", "😎", "🤩", "🤢", "💩", "🤑", "🤕", "🥴", "🤥", "🤬", "🤯", "🥶", "🥺", "😈"],
              cardColor: .yellow),

        Theme(name: "Food",
              emoji: ["🌭", "🍔", "🌮", "🍟", "🍕", "🍣", "🥟", "🍿", "🍩", "🍦"],
              cardColor: .purple),
        
        Theme(name: "Sport",
              emoji: ["⚽️", "🏀", "🏈", "⚾️", "🥎", "🎾", "🏐", "🏉", "🎱", "🏓", "🏒", "🏑", "🥋", "🥊", "🤿", "⛳️"],
              cardColor: .pink),
        
        Theme(name: "Animals",
              emoji: ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼", "🐨", "🐯", "🦁", "🐮", "🐷", "🐸", "🐵", "🦄"],
              cardColor: .red)
    ]
}


