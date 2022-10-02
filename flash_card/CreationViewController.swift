//
//  CreationViewController.swift
//  flash_card
//
//  Created by Maria Eduarda on 10/1/22.
//

import UIKit

class CreationViewController: UIViewController {
    
    var flashcardsController: ViewController!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func didTapOnCancel(_ sender: Any) {
        dismiss(animated: true)
    }
    
     @IBAction func didTapOnDone(_ sender: Any) {
         let questionText = questionTextField.text
         
         let answerText = answerTextField.text
         
         flashcardsController.updateFlashcard(question: questionText!, answer: answerText!)
         
         dismiss(animated: true)
     }
    

}
