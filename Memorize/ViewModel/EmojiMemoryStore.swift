//
//  EmojiMemoryStore.swift
//  Memorize
//
//  Created by Andrew Marmion on 19/06/2020.
//  Copyright © 2020 Andrew Marmion. All rights reserved.
//
import Foundation
import Combine

class EmojiMemoryStore: ObservableObject {
    @Published var themes: [Theme] = []

    private var autosave: AnyCancellable?

    let defaultsKey = "EmojiMemoryStore"

    init() {

        if let data = UserDefaults.standard.data(forKey: defaultsKey) {
            // load values from defaults and add them to the themes array
            let decoder = JSONDecoder()
            do {
                themes = try decoder.decode([Theme].self, from: data)
            } catch {
                fatalError("Could not load themes: \(error.localizedDescription)")
            }
        } else {
            themes = Theme.themes
        }

        autosave = $themes.sink { themes in
            // this is a very slow way to do this.
            // we are saving the whole themes array everytime there is a change, overkill
            // it would be better to save each theme individually
            do {
                let data = try JSONEncoder().encode(themes)
                UserDefaults.standard.set(data, forKey: self.defaultsKey)
            } catch {
                fatalError("Could not save themes: \(error.localizedDescription)")
            }
        }
    }
}
