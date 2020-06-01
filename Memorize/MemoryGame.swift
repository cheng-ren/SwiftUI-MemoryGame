//
//  MemoryGame.swift
//  Memorize
//
//  Created by 任成 on 2020/6/1.
//  Copyright © 2020 任成. All rights reserved.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    var cards: Array<Card>
        
    init(numberOfPairOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = Array<Card>()
        for pairIndex in 0..<numberOfPairOfCards {
            let cardContent = cardContentFactory(pairIndex)
            cards.append(Card(content:cardContent, id: pairIndex*2))
            cards.append(Card(content:cardContent, id: pairIndex*2+1))
        }
        var resultCards = Array<Card>()
        let loopCount = cards.count
        for _ in 0..<loopCount {
            let randomIndex = Int(arc4random()) % (loopCount - resultCards.count)
            resultCards.append(cards[randomIndex])
            cards.remove(at: randomIndex)
        }
        cards = resultCards
    }
    
    var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get {
            let faceUpCardIndices = cards.indices.filter { cards[$0].isFaceUp }
            if faceUpCardIndices.count == 1 {
                return faceUpCardIndices.first
            } else {
                return nil
            }
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = index == newValue
            }
        }
    }
    
    mutating func choose(card: Card) {
        print("card chosen: \(card)")
        if let chosenIndex = cards.firstIndex(of: card), !cards[chosenIndex].isFaceUp, !cards[chosenIndex].isMatched {
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                }
                cards[chosenIndex].isFaceUp = true
            } else {
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
            
            self.cards[chosenIndex].isFaceUp = true
        }
    }
    
    struct Card: Identifiable {
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent
        var id: Int
    }
}
