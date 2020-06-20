//
//  AddEmojiPopoverHeader.swift
//  Memorize
//
//  Created by Andrew Marmion on 20/06/2020.
//  Copyright © 2020 Andrew Marmion. All rights reserved.
//

import SwiftUI

struct AddEmojiPopoverHeader: View {

    var cancel: () -> Void
    var done: () -> Void
    var isDisabled: Bool

    var body: some View {
        HStack {
            Button(action: cancel,
                   label: { Text("Cancel").padding() })

            Spacer()

            Text("Add Emoji").font(.headline).padding()

            Spacer()

            Button(action: done,
                   label: { Text("Done").padding() })
                .disabled(isDisabled)
        }
    }
}

struct AddEmojiPopoverHeader_Previews: PreviewProvider {
    static var previews: some View {
        AddEmojiPopoverHeader(cancel: {}, done: {}, isDisabled: true)
    }
}
