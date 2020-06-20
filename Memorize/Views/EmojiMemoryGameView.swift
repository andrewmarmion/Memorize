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
        VStack {
            Grid(viewModel.cards) { card in
                CardView(card: card).onTapGesture {
                    withAnimation(.linear) {
                        self.viewModel.choose(card: card)
                    }
                }
                .padding(5)
            }
            Text("Score: \(viewModel.score)").frame(maxWidth: .infinity)
        }
        .alert(isPresented: $viewModel.gameComplete, content: createAlert)
        .padding()
        .foregroundColor(viewModel.theme.cardColor)
        .navigationBarTitle(viewModel.theme.name)
        .navigationBarItems(trailing: trailingNavigationButton())
    }
}

extension EmojiMemoryGameView {
    
    /// Creates a new game
    private func newGame() {
        withAnimation(.easeInOut) {
            self.viewModel.newGame()
        }
    }
    
    /// Creates an alert for the end of the game
    /// - Returns: The alert to display
    private func createAlert() -> Alert {
        Alert(title: Text("Game complete"),
          message: Text("You have completed the game.\nYou scored: \(viewModel.score)"),
        primaryButton: .cancel(Text("OK")),
        secondaryButton: .default(Text("New Game"), action: viewModel.newGame))
    }
    
    /// Creates a trailing navigation button
    /// - Returns: A button that creates a new game
    private func trailingNavigationButton() -> some View {
        Button(action: newGame, label: { Text("New Game") })
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(viewModel: EmojiMemoryGame(theme: Theme.themes[0]))
    }
}
