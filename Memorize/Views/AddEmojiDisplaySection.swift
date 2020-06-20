//
//  AddEmojiDisplaySection.swift
//  Memorize
//
//  Created by Andrew Marmion on 20/06/2020.
//  Copyright © 2020 Andrew Marmion. All rights reserved.
//

import SwiftUI

struct AddEmojiDisplaySection: View {

    var emojis: [String]
    var height: CGFloat
    var onTapGesture: (String) -> Void
    var onLongPressGesture: ((String) -> Void)?

    var body: some View {
        Grid(emojis, id: \.self) { emoji in
            Text(emoji).font(.largeTitle)
                .onTapGesture {
                    self.onTapGesture(emoji)
            }
            .onLongPressGesture {
                self.onLongPressGesture?(emoji)
            }
        }.frame(height: height)
    }
}

struct AddEmojiCurrentEmojiSection_Previews: PreviewProvider {
    static var previews: some View {
        AddEmojiDisplaySection(emojis: [""], height: 0.1, onTapGesture: {_ in })
    }
}
