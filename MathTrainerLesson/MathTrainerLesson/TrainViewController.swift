//
//  TrainViewController.swift
//  MathTrainerLesson
//
//  Created by Olya on 19.05.2024.
//

import UIKit

final class TrainViewController: UIViewController {
    //MARK: - Properties
    var type: MathTypes = .add {
        didSet {
            print(type)
        }
    }

    @IBOutlet var buttonsCollection: [UIButton]!
    
    @IBOutlet weak var backButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureButtons()
    }

    private func configureButtons() {
        //add shadow
        buttonsCollection.forEach { button in
            button.layer.shadowColor = UIColor.darkGray.cgColor
            button.layer.shadowOffset = CGSize(width: 0, height: 2)
            button.layer.shadowOpacity = 0.4
            button.layer.shadowRadius = 3
        }
        
        backButton.layer.shadowColor = UIColor.darkGray.cgColor
        backButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        backButton.layer.shadowOpacity = 0.4
        backButton.layer.shadowRadius = 3
    }
}

