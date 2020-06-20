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
    
    init(theme: Theme) {
        self.model = MemoryGame<String>(numberOfPairsOfCards: theme.numberOfPairs) { pairIndex in theme.emoji[pairIndex] }
        self.theme = theme
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
        self.model = MemoryGame<String>(numberOfPairsOfCards: theme.numberOfPairs) { pairIndex in theme.emoji[pairIndex] }
        self.gameComplete = false
    }
}


