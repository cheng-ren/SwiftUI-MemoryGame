//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by 任成 on 2020/6/1.
//  Copyright © 2020 任成. All rights reserved.
//  View-Model

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    @Published private(set) var model: MemoryGame<String> = EmojiMemoryGame.createMemmoryGame()
    
    static func createMemmoryGame() -> MemoryGame<String> {
        let emojis: Array<String> = ["😀", "🥶", "🥰", "🐬", "🐔", "🐶"]
        return MemoryGame<String>(numberOfPairOfCards: emojis.count) { pairIndex in
            emojis[pairIndex]
        }
    }
    
    // MARK - Access to the model
    
    var cards: Array<MemoryGame<String>.Card> { model.cards }
    
    // MARK - Intent(s)
    
    func choose(card: MemoryGame<String>.Card) {
        model.choose(card: card)
    }
}
