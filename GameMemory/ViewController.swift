//
//  ViewController.swift
//  iOSCesar
//
//  Created by Marlon Chalegre on 13/04/18.
//  Copyright © 2018 CESAR School. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var game: MemoryGame!
    //var emoticonDict = [Int:String]()
    var emoticons = ["👻", "🎃", "💀", "😈", "😱", "🦇", "🕷", "🤡", "🕸", "🦉"]
    
    @IBOutlet var cardButtons: [UIButton]!
    
    override func viewDidLoad() {
        self.game = MemoryGame(numberOfPairs: (cardButtons.count/2))
    }
    
    func updateGameScreen() {
        var cards = game.cards
        for index in cardButtons.indices {
            if cards[index].isUp {
                cardButtons[index].setTitle(selectEmoticon(for: cards[index].indentifier), for: .normal)
                cardButtons[index].backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
                cardButtons[index].isEnabled = false
            } else {
                cardButtons[index].setTitle("", for: .normal)
                cardButtons[index].backgroundColor = cards[index].isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1)
                cardButtons[index].isEnabled = cards[index].isMatched ? false : true
            }
        }
        self.labelJogadas.text = "Jogadas: \(game.pontos)"
        if(game.finalizou){
            alertGame()
        }
    }
    
    
    @IBOutlet weak var labelJogadas: UILabel!
    
    @IBAction func selectCard(_ sender: UIButton) {
        var position = 0
        for i in cardButtons.indices {
            if sender == cardButtons[i] {
                position = i
                break
            }
        }
        game.chooseCard(at: position)
        updateGameScreen()
    }
    
    func selectEmoticon(for id: Int) -> String {
        if emoticonDict[id] == nil {
            let randomIndex = Int(arc4random_uniform(UInt32(emoticons.count)))
            emoticonDict[id] = emoticons.remove(at: randomIndex)
        }
        return emoticonDict[id]!
    }
    
    func alertGame(){
        let alert = UIAlertController(title: "", message: "Você ganhou!", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Jogar novamente", style: .default, handler: { (action) in
            self.iniciarGame()
        }))
        
        alert.addAction(UIAlertAction(title: "Voltar para tela inicial", style: .default, handler: { (action) in
            self.navigationController?.popViewController(animated: true)
        }))
        
        present(alert, animated: true)
    }
    
    func iniciarGame(){
        self.game.newGame()
        self.labelJogadas.text = "Jogadas: 0"
        self.game.embaralharCartas()
        for index in self.cardButtons.indices {
            self.cardButtons[index].setTitle("", for: .normal)
            self.cardButtons[index].backgroundColor = #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1)
            self.cardButtons[index].isEnabled = true
        }
    }
}

