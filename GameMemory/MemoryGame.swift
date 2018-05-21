//
//  MemoryGame.swift
//  iOSCesar
//
//  Created by Marlon Chalegre on 14/04/18.
//  Copyright © 2018 CESAR School. All rights reserved.
//

import UIKit
import Foundation

class MemoryGame {
    
    var cards = [Card]()
    var acertou: Int = 0
    var totalBotao: Int = 0
    var finalizou: Bool = false
    var pontos: Int = 0
    
    init(numberOfPairs: Int) {
        for _ in 0..<numberOfPairs {
            let card = Card()
            cards += [card, card]
            totalBotao += 1
        }
        embaralharCartas()
    }
    
    func embaralharCartas(){
        var array = [Card]()
        while !cards.isEmpty {
            var aleatorio = Int(arc4random_uniform(UInt32(cards.count)))
            array.append(cards[aleatorio])
            cards.remove(at: aleatorio)
        }
        cards = array
    }
    
    func chooseCard(at index: Int) {
        let cardsUp = cards.indices.filter({ cards[$0].isUp })
        let currentUpCardIndex = cardsUp.count == 1 ? cardsUp.first : nil
        
        if !cards[index].isMatched {
            if let matchIndex = currentUpCardIndex {
                if matchIndex != index && cards[matchIndex].indentifier == cards[index].indentifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    
                    pontos += 2
                    
                    acertou += 1
                    if(acertou == totalBotao){
                        finalizou = true
                    } else {
                        finalizou = false
                    }
                }else{
                    pontos -= 1
                }
                cards[index].isUp = true
            } else {
                for i in cards.indices {
                    cards[i].isUp = (i == index)
                }
            }
        }
    }
    
    func newGame() {
        for i in cards.indices {
            cards[i].isMatched = false
        }
        pontos = 0
        acertou = 0
        finalizou = false
    }
}
