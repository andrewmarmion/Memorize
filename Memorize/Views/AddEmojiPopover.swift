//
//  AddEmojiPopover.swift
//  Memorize
//
//  Created by Andrew Marmion on 19/06/2020.
//  Copyright © 2020 Andrew Marmion. All rights reserved.
//

import SwiftUI
import Combine

struct AddEmojiPopover: View {

    /// An identifiable struct for displaying the alerts
    private struct AlertIdentifier: Identifiable {
        var id: Choice

        // The different alerts that can be displayed
        enum Choice {
            case warning
            case info
        }
    }

    @EnvironmentObject var store: EmojiMemoryStore
    @Environment(\.presentationMode) var presentationMode
    @Binding var theme: Theme?

    @State private var themeName: String = ""
    @State private var chosenEmoji: String = ""
    @State private var numberOfPairs: Int = 2
    @State private var chosenColor: Int? = nil
    @State private var emoji: Array<String> = []
    @State private var removedEmoji: Array<String> = []
    @State private var showAlert: AlertIdentifier?

    init(with theme: Binding<Theme?>) {
        _theme = theme

        // If we are passed a Theme then we need to set the state values accordingly
        if let theme = theme.wrappedValue {
            _themeName = State(initialValue: theme.name)
            _numberOfPairs = State(initialValue: theme.numberOfPairs)
            _chosenColor = State(initialValue: theme.color)
            _emoji = State(initialValue: theme.emoji)
            _removedEmoji = State(initialValue: theme.previousEmoji)
        }
    }

    var body: some View {
        VStack(spacing: 0) {

            AddEmojiPopoverHeader(cancel: closePopover,
                                  done: done,
                                  isDisabled: themeName.isEmpty || emoji.count < 2 || chosenColor == nil)
            Divider()

            Form {
                themeSection

                // Allow the user to add emoji
                addEmojiSection

                // Show the emoji that are currently available for play
                emojisInGameSection

                // Show the previously removed emoji
                emojisRemovedFromGameSection

                // Pick the number of pairs for the theme
                numberOfPairsSection

                // Pick the color for the theme
                colorPickerSection
            }
        }
            // Handle multiple alerts
            .alert(item: self.$showAlert, content: alert)
    }


    /// Creates the alerts that can be displayed
    /// - Parameter alert: The alert identifier
    /// - Returns: The alert for the given identifier
    private func alert(_ alert: AlertIdentifier) -> Alert {
        switch alert.id {
        case .warning:
            return Alert(title: Text("Too Few Emoji"),
                         message: Text("You must add at least two emoji to your theme."),
                         dismissButton: .default(Text("OK")))
        case .info:
            return Alert(title: Text("Permanently Remove Emoji"),
                         message: Text("To permanently remove an emoji from your theme, long press on the emoji."),
                         dismissButton: .default(Text("OK")))
        }
    }

    /// Calculates the height of the grid based on the number of elements inside it
    /// - Parameter count: The number of elements
    /// - Returns: The height
    private func height(for count: Int) -> CGFloat {
        CGFloat((count - 1) / 6 * 70 + 70)
    }

    /// Called when the done button is tapped
    private func done() {
        if emoji.count >= 2 && !themeName.isEmpty && chosenColor != nil {

            // if we are editing a theme then lets update the theme at the index
            if let theme = theme, let index = self.store.themes.firstIndex(where: { $0.id == theme.id }) {
                self.store.themes[index] = Theme(id: theme.id,
                                                 name: themeName,
                                                 emoji: emoji,
                                                 numberOfPairs: numberOfPairs,
                                                 color: chosenColor!,
                                                 previousEmoji: removedEmoji)

            } else {
                // We are adding a new theme so let's insert it into the store
                self.store.themes.append(Theme(name: themeName,
                                               emoji: emoji,
                                               numberOfPairs: numberOfPairs,
                                               color: chosenColor!,
                                               previousEmoji: removedEmoji))
            }

            self.closePopover()
        } else {
            self.showAlert = AlertIdentifier(id: .warning)
        }
    }


    /// Adds an emoji to the array of emojis
    ///
    /// Handles duplicates by checking that they do not exist in the current array
    /// - Parameter emoji: The emoji that we wish to add
    private func addEmoji(_ emoji: String) {
        if self.numberOfPairs == self.emoji.count && self.numberOfPairs > 2 {
            self.numberOfPairs -= 1
        }
        self.emoji.setRemove(emoji)
        self.removedEmoji.append(emoji)
    }


    /// Re-adds the emoji from the previously removed emojis to the current in game emojis
    /// - Parameter emoji: the emoji that we wish to re add to the game
    private func reAddEmoji(_ emoji: String) {
        self.removedEmoji.setRemove(emoji)
        self.emoji.append(emoji)
    }


    /// Deletes the emoji from the game
    /// - Parameter emoji: the emoji that we wish to delete
    private func deleteEmoji(_ emoji: String) {
        self.removedEmoji.setRemove(emoji)
    }

    /// Handles closing the popover
    private func closePopover() {
        presentationMode.wrappedValue.dismiss()
        // We are required to set the theme to nil as we are using the AddEmojiPopover
        // for adding and editing, if the passed theme is not set to nil when we are finished
        // editing the theme, then when we add a new theme we will be presented with the previous
        // theme we were editing and not an empty theme.
        self.theme = nil

    }
}

extension AddEmojiPopover {

    /// Displays the theme's name
    var themeSection: some View {
        Section {
            TextField("Theme Name", text: $themeName)
        }
    }


    /// Allows the user to add emojis to the games
    var addEmojiSection: some View {
        Section(header: Text("Add emoji")) {
            AddEmojiSection(chosenEmoji: $chosenEmoji, action: {
                for emoji in self.chosenEmoji {
                    self.emoji.setInsert(String(emoji))
                    self.removedEmoji.setRemove(String(emoji))
                }
                self.chosenEmoji = ""
            })
        }
    }


    /// Displats the emojis that the user can play with
    var emojisInGameSection: some View {
        Section(header: HStack {
            Text("Emoji")
            Spacer()
            Text("Tap emoji to remove it")
            },
                content: {
                    AddEmojiDisplaySection(emojis: emoji,
                                           height: self.height(for: self.emoji.count),
                                           onTapGesture: addEmoji)
        })
    }

    /// Displays the previously removed emojis
    var emojisRemovedFromGameSection: some View {
        Section(header: HStack {
            Text("Previously Removed Emoji")
            Spacer()
            HStack {
                Text("Tap emoji to re-add it")

                Button(action: { self.showAlert = AlertIdentifier(id: .info) }, label: {
                    Image(systemName: "info.circle.fill")
                })}
            },
                content: {
                    AddEmojiDisplaySection(emojis: removedEmoji,
                                           height: self.height(for: self.removedEmoji.count),
                                           onTapGesture: reAddEmoji,
                                           onLongPressGesture: deleteEmoji)
        })
    }

    /// Displays the numbe rof pairs in the section
    var numberOfPairsSection: some View {
        Section(header: Text("Card Count"), content: {
            HStack {
                Text("\(numberOfPairs) Pairs")
                Spacer()
                Stepper("", value: $numberOfPairs, in: 2...max(emoji.count, 2)).disabled(self.emoji.count < 2)
            }
        })
    }

    /// Displays the color picker
    var colorPickerSection: some View {
        Section(header: Text("Color"), content: {
            Grid(colors, id: \.self) { color in
                RoundedRectangle(cornerRadius: 5)
                    .fill(Color(color))
                    .frame(width: 44, height: 44)
                    .showOutline(showOutline: color == ( colors[self.chosenColor ?? 0]))
                    .onTapGesture {
                        self.chosenColor = colors.firstIndex(of: color)
                }
            }.frame(height: self.height(for: colors.count))

        })
    }
}
 
let colors: [UIColor] = [.systemRed,
                         .systemPink,
                         .systemOrange,
                         .systemYellow,
                         .systemGray,
                         .systemGreen,
                         .systemTeal,
                         .systemBlue,
                         .systemPurple,
                         .systemIndigo]
