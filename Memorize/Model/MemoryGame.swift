//
//  MemoryGame.swift
//  Memorize
//
//  Created by Andrew Marmion on 20/05/2020.
//  Copyright © 2020 Andrew Marmion. All rights reserved.
//

import Foundation

struct MemoryGame<CardContent: Equatable & Hashable> {
    
    private(set) var cards: Array<Card>
    private(set) var score: Int = 0
    
    var gameComplete: Bool {
        cards.count == matchedCards.count
    }
    
    // Does this need to be a set? Would an array be ok? Would it be better to just store a count?
    private var matchedCards: Set<Card> = []
    
    private var indexOfTheOneAndOnlyFaceUpCard: Int? {
        
        get { cards.indices.filter { cards[$0].isFaceUp }.only }
        
        set {
            for index in cards.indices {
                cards[index].isFaceUp = index == newValue
            }
        }
    }
    
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
        if let chosenIndex: Int = cards.firstIndex(of: card),
            !cards[chosenIndex].isFaceUp,
            !cards[chosenIndex].isMatched {
            
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                    
                    score += 2
                    matchedCards.insert(cards[chosenIndex])
                    matchedCards.insert(cards[potentialMatchIndex])
                    
                } else {
                    score -= 1 // are there any edge cases that could require a better solution than this?
                }
                cards[chosenIndex].isFaceUp = true
            } else {
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
        }
    }
    
    /// A card that is used in the game
    struct Card: Identifiable, Equatable, Hashable {
        
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
