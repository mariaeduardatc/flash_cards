//
//  ViewController.swift
//  flash_card
//
//  Created by Maria Eduarda on 9/18/22.
//

import UIKit
struct Flashcard{
    var question : String
    var answer: String
}

class ViewController: UIViewController {
    @IBOutlet weak var backLabel: UILabel!
    @IBOutlet weak var frontLabel: UILabel!
    
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var prevButton: UIButton!
    
    @IBOutlet weak var cardContainer: UIView!
    @IBOutlet weak var card: UIView!
    // array to hold our flashcards
    // [Flashcard]() creates an array and tells iOS that we are going to be putting objects of type Flashcard in it.
    var flashcards = [Flashcard]()
    
    var currentIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // card style
        backLabel.layer.cornerRadius = 10.0
        frontLabel.layer.cornerRadius = 10.0
        frontLabel.clipsToBounds = true
        backLabel.clipsToBounds = true
        
        cardContainer.layer.shadowRadius = 15.0
        cardContainer.layer.shadowOpacity = 0.2
        
        
        readSavedFlashcards()
        
        // Do any additional setup after loading the view.
        if flashcards.count == 0 {
            updateFlashcard(question: "What is the biggest animal on the planet?", answer: "Blue Whale")
        }else{
            updateLabels()
            updateNextPrevButtons()
        }
    }

    @IBAction func tapOnBack(_ sender: Any) {
        flipFlashcard(state: false)
    }
    
    
    @IBAction func tapOnScreen(_ sender: Any) {
        flipFlashcard(state: true)
    }
    
    func flipFlashcard(state: Bool){
        UIView.transition(with: card, duration: 0.3, options: .transitionFlipFromRight) {
            self.frontLabel.isHidden = state
        }
    }
    
    func animateCardOut(){
        UIView.animate(withDuration: 0.2, animations: {self.card.transform = CGAffineTransform.identity.translatedBy(x: -300.0, y: 0.0)}, completion: {finished in
            
            self.updateLabels()
            
            self.animateCardIn()
        })
    }
    
    func animateCardIn(){
        
        card.transform = CGAffineTransform.identity.translatedBy(x: 300.0, y: 0.0)
        
        UIView.animate(withDuration:0.2){
            self.card.transform = CGAffineTransform.identity
        }
        
    }
    
    // if we type on prev
    func animateCardOutPrev(){
        UIView.animate(withDuration: 0.2, animations: {self.card.transform = CGAffineTransform.identity.translatedBy(x: 300.0, y: 0.0)}, completion: {finished in
            
            self.updateLabels()
            
            self.animateCardInPrev()
        })
    }
    
    func animateCardInPrev(){
        
        // copia
        card.transform = CGAffineTransform.identity.translatedBy(x: -300.0, y: 0.0)
        
        UIView.animate(withDuration:0.2){
            self.card.transform = CGAffineTransform.identity
        }
        
    }
        
    
    
    @IBAction func didTapOnNext(_ sender: Any) {
        currentIndex = currentIndex + 1
        
        updateNextPrevButtons()
        
        animateCardOut()
    }
    
    @IBAction func didTapOnPrev(_ sender: Any) {
        
        currentIndex = currentIndex - 1
        
        updateNextPrevButtons()
        
        animateCardOutPrev()
    }
    
    func updateLabels(){
        let currentFlashcard = flashcards[currentIndex]
        
        frontLabel.text = currentFlashcard.question
        backLabel.text = currentFlashcard.answer
    }
    
    func updateFlashcard(question: String, answer: String){
        let flashcard = Flashcard(question: question, answer: answer)
        
        flashcards.append(flashcard)
        
        currentIndex = flashcards.count - 1
        
        print(currentIndex)
        
        updateNextPrevButtons()
        updateLabels()
        saveAllFlashcardsToDisk()
    }
    
    func updateNextPrevButtons(){
        if currentIndex == flashcards.count - 1{
            nextButton.isEnabled = false
        }else{
            nextButton.isEnabled = true
        }
    }
    
    func saveAllFlashcardsToDisk(){
        let dictionaryArray = flashcards.map{(card) -> [String: String] in return ["question": card.question, "answer": card.answer]
            
        }
        
        UserDefaults.standard.set(dictionaryArray, forKey: "flashcards")
    }
    
    func readSavedFlashcards(){
        if let dictionaryArray = UserDefaults.standard.array(forKey: "flashcards") as? [[String: String]]{
            let savedCards = dictionaryArray.map{dictionary -> Flashcard in
                return Flashcard(question: dictionary["question"]!, answer: dictionary["answer"]!)}
            flashcards.append(contentsOf: savedCards)
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        let navigationController = segue.destination as! UINavigationController
        let creationController = navigationController.topViewController as! CreationViewController
        
        creationController.flashcardsController = self
        
        updateNextPrevButtons()
    }
    
    
}

