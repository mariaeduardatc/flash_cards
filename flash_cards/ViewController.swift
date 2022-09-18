//
//  ViewController.swift
//  falsh_cards
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
    

}

