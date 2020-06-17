//
//  CardView.swift
//  Memorize
//
//  Created by Andrew Marmion on 26/05/2020.
//  Copyright © 2020 Andrew Marmion. All rights reserved.
//

import SwiftUI

struct CardView: View {
    
    private var card: MemoryGame<String>.Card
    
    init(card: MemoryGame<String>.Card) {
        self.card = card
    }
    
    var body: some View {
        GeometryReader { geometry in
            self.body(for: geometry.size)
        }
    }
    
    @State private var animatedBonusRemaining: Double = 0
    
    private func startBonusTimeAnimation() {
        animatedBonusRemaining = card.bonusRemaining
        withAnimation(.linear(duration: card.bonusTimeRemaining)) {
            animatedBonusRemaining = 0
        }
    }
    
    /// A helper function to avoid using self
    /// - Parameter size: The size of the card
    /// - Returns: The card
    @ViewBuilder
    private func body(for size: CGSize) -> some View {
        if card.isFaceUp || !card.isMatched {
            ZStack {
                Group {
                    if card.isConsumingBonusTime {
                        Pie(startAngle: .init(degrees: 0-90),
                            endAngle: .init(degrees: -animatedBonusRemaining * 360 - 90),
                            clockwise: true)
                            .onAppear(perform: startBonusTimeAnimation)
                    } else {
                        Pie(startAngle: .init(degrees: 0-90),
                            endAngle: .init(degrees: -card.bonusRemaining * 360 - 90),
                            clockwise: true)
                            .padding(5)
                            .opacity(0.4)
                    }
                }
                .padding(5)
                .opacity(0.4)
                
                Text(card.content)
                    .font(.system(size: fontSize(for: size)))
                    .rotationEffect(.init(degrees: card.isMatched ? 360 : 0))
                    .animation(card.isMatched ? Animation.linear(duration: 1).repeatForever(autoreverses: false) : .default)
            }
            .cardify(isFaceUp: card.isFaceUp)
            .transition(AnyTransition.scale)
        }
    }
    
    // MARK: - Drawing Constants
    
    private let fontScaleFactor: CGFloat = 0.7
    
    
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
                .previewLayout(.fixed(width: 200, height: 300))
                .padding()
            
            CardView(card: MemoryGame<String>.Card(isFaceUp: true, isMatched: false, content: "👻", id: 0))
                .previewLayout(.fixed(width: 200, height: 300))
                .padding()
            
            CardView(card: MemoryGame<String>.Card(isFaceUp: true, isMatched: true, content: "🎃", id: 0))
                .previewLayout(.fixed(width: 300, height: 200))
                .padding()
        }
        .background(Color.white)
        .foregroundColor(.orange)
        
    }
}


