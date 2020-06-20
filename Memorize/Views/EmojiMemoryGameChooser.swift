//
//  EmojiMemoryGameChooser.swift
//  Memorize
//
//  Created by Andrew Marmion on 19/06/2020.
//  Copyright © 2020 Andrew Marmion. All rights reserved.
//

import SwiftUI
import Combine

struct EmojiMemoryGameChooser: View {
    @EnvironmentObject var store: EmojiMemoryStore

    @State private var showingAddEmojiPopover: Bool = false
    @State private var editMode: EditMode = .inactive
    @State private var editingTheme: Theme? = nil

    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(store.themes) { theme in
                        NavigationLink(destination: EmojiMemoryGameView(viewModel: EmojiMemoryGame(theme: theme))) {
                            ThemeRow(theme: theme, actionOnEdit: {
                                self.editingTheme = theme
                                self.showingAddEmojiPopover = true
                            })
                        }
                    }
                    .onDelete { indexSet in
                        indexSet.forEach { self.store.themes.remove(at: $0) }
                    }
                }
            }


            .sheet(isPresented: $showingAddEmojiPopover) {
                AddEmojiPopover(with: self.$editingTheme)
                    .environmentObject(self.store)
            }
            .navigationBarTitle("Memorize")
            .navigationBarItems(leading: Button(action: addEmoji, label: { Image(systemName: "plus").imageScale(.large)}),
                                trailing: EditButton())
                .environment(\.editMode, $editMode)
            
            
        }
    }

    private func addEmoji() {
        self.showingAddEmojiPopover = true
    }
}



struct EmojiMemoryGameChooser_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameChooser().environmentObject(EmojiMemoryStore())
    }
}


