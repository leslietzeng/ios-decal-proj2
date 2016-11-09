//
//  GameViewController.swift
//  Hangman
//
//  Created by Shawn D'Souza on 3/3/16.
//  Copyright © 2016 Shawn D'Souza. All rights reserved.
//

import UIKit


//from http://stackoverflow.com/questions/27535901/ios-8-change-character-spacing-on-uilabel-within-interface-builder
extension UILabel{
    func addTextSpacing(spacing: CGFloat){
        let attributedString = NSMutableAttributedString(string: self.text!)
        attributedString.addAttribute(NSKernAttributeName, value: spacing, range: NSRange(location: 0, length: self.text!.characters.count))
        self.attributedText = attributedString
    }
}

class GameViewController: UIViewController {
    
    
    
    
    // Data
    var currentSelection:UIButton? = nil
    var incorrectLabelText:String = ""
    var phraseLabelText:String = ""
    var charToStringOffsets = [Character:[Int]]()
    // MARK: Outlets
    @IBOutlet weak var gallowsImage: UIImageView!
    @IBOutlet weak var phraseLabel: UILabel!
    @IBOutlet weak var incorrectLabel: UILabel!
    @IBOutlet weak var inputA: UIButton!
    @IBOutlet weak var inputB: UIButton!
    @IBOutlet weak var inputC: UIButton!
    @IBOutlet weak var inputD: UIButton!
    @IBOutlet weak var inputE: UIButton!
    @IBOutlet weak var inputF: UIButton!
    @IBOutlet weak var inputG: UIButton!
    @IBOutlet weak var inputH: UIButton!
    @IBOutlet weak var inputI: UIButton!
    @IBOutlet weak var inputJ: UIButton!
    @IBOutlet weak var inputK: UIButton!
    @IBOutlet weak var inputL: UIButton!
    @IBOutlet weak var inputM: UIButton!
    @IBOutlet weak var inputN: UIButton!
    @IBOutlet weak var inputO: UIButton!
    @IBOutlet weak var inputP: UIButton!
    @IBOutlet weak var inputQ: UIButton!
    @IBOutlet weak var inputR: UIButton!
    @IBOutlet weak var inputS: UIButton!
    @IBOutlet weak var inputT: UIButton!
    @IBOutlet weak var inputU: UIButton!
    @IBOutlet weak var inputV: UIButton!
    @IBOutlet weak var inputW: UIButton!
    @IBOutlet weak var inputX: UIButton!
    @IBOutlet weak var inputY: UIButton!
    @IBOutlet weak var inputZ: UIButton!
    @IBOutlet weak var guessButton: UIButton!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let hangmanPhrases = HangmanPhrases()
        let phrase = hangmanPhrases.getRandomPhrase()
        print(phrase!)
        
        phraseLabel.text = phraseLabelText
        incorrectLabel.text = incorrectLabelText
        loadWord(phrase)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: Action
    @IBAction func selectLetter(_ sender: UIButton) {
        if let previous = currentSelection {
            previous.isSelected = false
            
        }
        sender.isSelected = true
        currentSelection = sender
    }
    
    @IBAction func pressGuess(_ sender: UIButton) {
        if let previous = currentSelection {
            previous.isSelected = false
            previous.isEnabled = false
            //do more stuff
            if guess(previous.titleLabel!.text![previous.titleLabel!.text!.startIndex]) {
                sender.isEnabled = false
            }
            currentSelection = nil

        }
    }
    
    @IBAction func startOver(_ sender: UIButton) {
        gallowsImage.image = UIImage(named:"hangman1.gif")
        currentSelection = nil
        phraseLabelText = ""
        incorrectLabelText = ""
        charToStringOffsets.removeAll()
        
        incorrectLabel.text = incorrectLabelText
        let hangmanPhrases = HangmanPhrases()
        let phrase = hangmanPhrases.getRandomPhrase()
        print(phrase!)
        loadWord(phrase)
        inputA.isEnabled = true
        inputB.isEnabled = true
        inputC.isEnabled = true
        inputD.isEnabled = true
        inputE.isEnabled = true
        inputF.isEnabled = true
        inputG.isEnabled = true
        inputH.isEnabled = true
        inputI.isEnabled = true
        inputJ.isEnabled = true
        inputK.isEnabled = true
        inputL.isEnabled = true
        inputM.isEnabled = true
        inputN.isEnabled = true
        inputO.isEnabled = true
        inputP.isEnabled = true
        inputQ.isEnabled = true
        inputR.isEnabled = true
        inputS.isEnabled = true
        inputT.isEnabled = true
        inputU.isEnabled = true
        inputV.isEnabled = true
        inputW.isEnabled = true
        inputX.isEnabled = true
        inputY.isEnabled = true
        inputZ.isEnabled = true
        guessButton.isEnabled = true

        
    }
    
    //MARK: Loading, Reloading, and Guessing capabilities
    func loadWord(_ phrase: String?) {
        var counter = 0
        //load phrase
        for c in (phrase?.characters)! {
            if let _ = charToStringOffsets[c] {
                charToStringOffsets[c]!.append(counter)
                phraseLabelText.append("_")
                counter += 1
                
            } else if c == " "{
                phraseLabelText.append("  ")
                counter += 2
                
            } else {
                charToStringOffsets[c] = [Int]()
                charToStringOffsets[c]!.append(counter)
                phraseLabelText.append("_")
                counter += 1
            }
            
        }
        phraseLabel.text = phraseLabelText
        phraseLabel.addTextSpacing(spacing: 1.5)
        
        
        print(charToStringOffsets)

    }
    
    
    
    func guess(_ char: Character) -> Bool {
        //true if game ended, false otherwise
        if let locationArray = charToStringOffsets[char] {
            for location in locationArray {
                let index = phraseLabelText.index(phraseLabelText.startIndex, offsetBy: location)
                phraseLabelText.remove(at: index)
                phraseLabelText.insert(char, at: index)
            }
            charToStringOffsets.removeValue(forKey: char)
            phraseLabel.text = phraseLabelText
            phraseLabel.addTextSpacing(spacing: 2)

            print(phraseLabel.text!)
            print(charToStringOffsets)
        } else {
            incorrectLabelText.append(char)
            incorrectLabelText.append(" ")
            incorrectLabel.text = incorrectLabelText
            let numIncorrect:Int = incorrectLabelText.characters.count / 2
            let filepath = "hangman\(numIncorrect + 1).gif"
            gallowsImage.image = UIImage(named: filepath)
            
        }
        if charToStringOffsets.isEmpty {
            //raise alert for win.
            let alertController = UIAlertController(
                title: "You Win!",
                message: "Press Start Over to play again.",
                preferredStyle: .alert)
            
            
            let okayButton = UIAlertAction(title: "OK", style: .default) { (action) in
                alertController.dismiss(animated: true, completion: nil)
            }
            let returnToHome = UIAlertAction(title: "Return to Home Screen", style: .default) { (action) in
                self.dismiss(animated: true, completion: nil)
            }
            
            alertController.addAction(returnToHome)
            alertController.addAction(okayButton)
            present(alertController, animated: true, completion: nil)
            return true
        }
        if incorrectLabelText.characters.count == 12 {
            //raise alert for loss
            let alertController = UIAlertController(
                title: "You Lose!",
                message: "Press Start Over to play again.",
                preferredStyle: .alert)
            
            
            let okayButton = UIAlertAction(title: "OK", style: .default) { (action) in
                alertController.dismiss(animated: true, completion: nil)
            }
            let returnToHome = UIAlertAction(title: "Return to Home Screen", style: .default) { (action) in
                self.dismiss(animated: true, completion: nil)
            }
            
            alertController.addAction(returnToHome)
            alertController.addAction(okayButton)
            present(alertController, animated: true, completion: nil)
            return true
        }
        return false
        
    }
    

}
