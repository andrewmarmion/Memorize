//
//  AddEmojiSection.swift
//  Memorize
//
//  Created by Andrew Marmion on 20/06/2020.
//  Copyright © 2020 Andrew Marmion. All rights reserved.
//

import SwiftUI

struct AddEmojiSection: View {
    @Binding var chosenEmoji: String
    var action: () -> Void

    var body: some View {
        HStack {
            TextField("Emoji", text: $chosenEmoji)
            Spacer()
            Button(action: action,
                   label: { Text("Add") })
        }
    }
}

struct AddEmojiSection_Previews: PreviewProvider {
    static var previews: some View {
        AddEmojiSection(chosenEmoji: .constant(""), action: {})
    }
}
