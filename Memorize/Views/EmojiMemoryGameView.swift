//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Andrew Marmion on 20/05/2020.
//  Copyright © 2020 Andrew Marmion. All rights reserved.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject private var viewModel: EmojiMemoryGame
    
    init(viewModel: EmojiMemoryGame) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Grid(viewModel.cards) { card in
                    CardView(card: card).onTapGesture {
                        self.viewModel.choose(card: card)
                    }
                    .padding(5)
                }
                Text("Score: \(viewModel.score)")
            }
            .alert(isPresented: $viewModel.gameComplete, content: {
                Alert(title: Text("Game complete"),
                      message: Text("You have completed the game.\nYou scored: \(viewModel.score)"),
                    primaryButton: .cancel(Text("OK")),
                    secondaryButton: .default(Text("New Game"), action: viewModel.newGame))
            })
            .padding()
            .foregroundColor(viewModel.theme.cardColor)
            .navigationBarTitle(viewModel.theme.name)
            .navigationBarItems(trailing: Button(action: viewModel.newGame, label: { Text("New Game") }))
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(viewModel: EmojiMemoryGame())
    }
}
