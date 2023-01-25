//
//  WelcomeViewController.swift
//  SwiftBook
//
//  Created by Yuri on 08.01.2023.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    @IBOutlet var welcomeLabel: UILabel!
    @IBOutlet var smileLabel: UILabel!
    
    var userName: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //setGradientBackground()
        
        self.view.layer.insertSublayer(
            UIViewController.gradientLayer(bounds: self.view.bounds),
            at: 0
        )
        
        welcomeLabel.text = "Greetings, " + userName + "!"
    }
    
    @IBAction func logOutButtonPressed() {
        dismiss(animated: true)
    }
}
