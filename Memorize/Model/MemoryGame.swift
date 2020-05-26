//
//  MemoryGame.swift
//  Memorize
//
//  Created by Andrew Marmion on 20/05/2020.
//  Copyright © 2020 Andrew Marmion. All rights reserved.
//

import Foundation

struct MemoryGame<CardContent: Equatable> {
    var cards: Array<Card>
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = Array<Card>()
        for pairIndex in 0..<numberOfPairsOfCards {
            let content: CardContent = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: pairIndex * 2))
            cards.append(Card(content: content, id: pairIndex * 2 + 1))

        }
        cards.shuffle()
    }
    
    /// Toggles the card's isFaceUp value
    /// - Parameter card: The card we wish to change
    mutating func choose(card: Card) {
        let chosenIndex: Int = self.index(of: card)
        self.cards[chosenIndex].isFaceUp = !self.cards[chosenIndex].isFaceUp
    }
    
    
    /// Finds the index of the card in the cards array
    /// - Parameter card: The card whose index we are looking for
    /// - Returns: The index of the card we were looking for
    private func index(of card: Card) -> Int {
        
        guard let index = cards.firstIndex(of: card) else {
            fatalError("\(card) not found")
        }
        
        return index
    }
    
    
    /// A card that is used in the game
    struct Card: Identifiable, Equatable {

        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent
        var id: Int
        
        static func == (lhs: MemoryGame<CardContent>.Card, rhs: MemoryGame<CardContent>.Card) -> Bool {
            lhs.id == rhs.id &&
                lhs.content == rhs.content &&
                lhs.isFaceUp == rhs.isFaceUp &&
                lhs.isMatched == rhs.isMatched
        }
    }
}
