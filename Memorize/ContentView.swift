//
//  ContentView.swift
//  Memorize
//
//  Created by Andrew Marmion on 20/05/2020.
//  Copyright © 2020 Andrew Marmion. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var viewModel: EmojiMemoryGame
    
    var body: some View {
        HStack {
            ForEach(viewModel.cards) { card in
                CardView(card: card).onTapGesture {
                    self.viewModel.choose(card: card)
                }.aspectRatio(0.666666666, contentMode: .fit)
            }
        }
        .padding()
        .foregroundColor(Color.orange)
        .font(viewModel.cards.count <= 8 ? .largeTitle : .title)
    }
}
 
struct CardView: View {
    var card: MemoryGame<String>.Card
    
    var body: some View {
        ZStack {
            if card.isFaceUp {
                RoundedRectangle(cornerRadius: 10).fill(Color.white)
                RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 3)
                Text(card.content)
            } else {
                RoundedRectangle(cornerRadius: 10).fill()
            }
        }
    }
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: EmojiMemoryGame())
    }
}
