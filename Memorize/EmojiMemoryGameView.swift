//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by 任成 on 2020/6/1.
//  Copyright © 2020 任成. All rights reserved.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        Grid(viewModel.cards) { card in
            CardView(card: card).onTapGesture {
                withAnimation {
                    self.viewModel.choose(card: card)
                }
            }
        .padding(5)
        }
        .padding()
        .foregroundColor(.orange)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(viewModel: EmojiMemoryGame())
    }
}

struct CardView: View {
    var card: MemoryGame<String>.Card
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(content: {
                if self.card.isFaceUp {
                    RoundedRectangle(cornerRadius: self.cornerRadius).fill(Color.white)
                    RoundedRectangle(cornerRadius: self.cornerRadius).stroke(lineWidth: self.edgeLineWidth)
                    Text(self.card.content)
                } else {
                    if !self.card.isMatched {
                        RoundedRectangle(cornerRadius: self.cornerRadius).fill()
                    }
                }
            })
                .font(Font.system(size: self.fontSize(for: geometry.size)))
                .animation(.easeInOut)
        }
    }
    
    // MARK - Drawing Constants
    
    let cornerRadius: CGFloat = 10.0
    let edgeLineWidth: CGFloat = 3.0
    let fontScaleFactor: CGFloat = 0.75
    
    func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * self.fontScaleFactor
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(card: EmojiMemoryGame().cards[0]).previewLayout(.fixed(width: 200, height: 200))
    }
}
