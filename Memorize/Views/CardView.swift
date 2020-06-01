//
//  CardView.swift
//  Memorize
//
//  Created by Andrew Marmion on 26/05/2020.
//  Copyright © 2020 Andrew Marmion. All rights reserved.
//

import SwiftUI

struct CardView: View {
    
    var card: MemoryGame<String>.Card
    
    var body: some View {
        GeometryReader { geometry in
            self.body(for: geometry.size)
        }
    }
    

    /// A helper function to avoid using self
    /// - Parameter size: The size of the card
    /// - Returns: The card
    func body(for size: CGSize) -> some View {
        ZStack {
            if card.isFaceUp {
                RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
                RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: edgeLineWidth)
                Text(card.content)
            } else {
                // Don't show anything if the card is matched.
                if !card.isMatched {
                    RoundedRectangle(cornerRadius: cornerRadius).fill()
                }
            }
        }
        .font(.system(size: fontSize(for: size)))
    }
    
    // MARK: - Drawing Constants
    
    private let cornerRadius: CGFloat = 10
    private let edgeLineWidth: CGFloat = 3
    private let fontScaleFactor: CGFloat = 0.75
    
    
    /// Calculates the font size based on the card size
    /// - Parameter size: The GCSize of the item
    /// - Returns: A CGFloat for the size of the font that will best fit the card
    private func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * fontScaleFactor
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CardView(card: MemoryGame<String>.Card(content: "👻", id: 0))
                .previewLayout(.fixed(width: 100, height: 150))
                .padding()
            
            CardView(card: MemoryGame<String>.Card(isFaceUp: true, isMatched: false, content: "👻", id: 0))
                .previewLayout(.fixed(width: 100, height: 150))
                .padding()
            
            CardView(card: MemoryGame<String>.Card(isFaceUp: true, isMatched: true, content: "🎃", id: 0))
                .previewLayout(.fixed(width: 100, height: 150))
                .padding()
        }
        .background(Color.white)
        .foregroundColor(.orange)
        
    }
}
