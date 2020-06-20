//
//  ThemeRow.swift
//  Memorize
//
//  Created by Andrew Marmion on 19/06/2020.
//  Copyright © 2020 Andrew Marmion. All rights reserved.
//

import SwiftUI

struct ThemeRow: View {

    let theme: Theme
    let actionOnEdit: () -> Void


    /// Holds up to five of the emojis in the theme
    var emojis: [String] {
        Array(theme.emoji.prefix(5))
    }

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                HStack {
                    Text(theme.name).font(.title)
                    Button(action: actionOnEdit, label: { Image(systemName: "pencil.circle") })
                        .buttonStyle(BorderlessButtonStyle())
                }

                HStack {
                    ForEach(emojis, id: \.self) {
                        Text($0)
                    }
                }
            }

            Spacer()

            // Shows the theme color
            RoundedRectangle(cornerRadius: 5)
                .fill(theme.cardColor)
                .frame(width: 44, height: 44)
                .overlay(Text("\(theme.emoji.count)"))
        }
    }
}

struct ThemeRow_Previews: PreviewProvider {
    static var previews: some View {
        ThemeRow(theme: Theme.themes[0], actionOnEdit: {})
    }
}
