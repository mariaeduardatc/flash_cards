//
//  ViewController.swift
//  flash_card
//
//  Created by Maria Eduarda on 9/18/22.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var backLabel: UILabel!
    @IBOutlet weak var frontLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func tapOnScreen(_ sender: Any) {
        frontLabel.isHidden = true
    }
    
    func updateFlashcard(question: String, answer: String){
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        let navigationController = segue.destination as! UINavigationController
        let creationController = navigationController.topViewController as! CreationViewController
        
        creationController.flashcardsController = self
    }
    
}

