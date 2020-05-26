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
    
    func body(for size: CGSize) -> some View {
        ZStack {
            if card.isFaceUp {
                RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
                RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: edgeLineWidth)
                Text(card.content)
            } else {
                RoundedRectangle(cornerRadius: cornerRadius).fill()
            }
        }
        .font(.system(size: fontSize(for: size)))
    }
    
    // MARK: - Drawing Constants
    
    private let cornerRadius: CGFloat = 10
    private let edgeLineWidth: CGFloat = 3
    private let fontScaleFactor: CGFloat = 0.75
    
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
