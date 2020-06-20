//
//  OutlineModifier.swift
//  EmojiArt
//
//  Created by Andrew Marmion on 16/06/2020.
//  Copyright © 2020 Andrew Marmion. All rights reserved.
//

import SwiftUI

struct OutlineModifier: ViewModifier {

    let showOutline: Bool
    let color: Color

    func body(content: Content) -> some View {
        content.overlay(
            RoundedRectangle(cornerRadius: 5)
                .stroke(lineWidth: showOutline ? 5 : 0)
                .foregroundColor(color)
        )
    }
}

extension View {
    func showOutline(showOutline: Bool, color: Color = .secondary) -> some View {
        self.modifier(OutlineModifier(showOutline: showOutline, color: color))
    }
}
