//
//  ViewController.swift
//  MathTrainerLesson
//
//  Created by Olya on 13.05.2024.
//

import UIKit

enum MathTypes: Int {
    case add
    case subtract
    case multiply
    case divide

    var stringValue: String {
        switch self {
        case .add:
            return "+"
        case .subtract:
            return "-"
        case .multiply:
            return "*"
        case .divide:
            return "/"
        }
    }
}

class ViewController: UIViewController {

    //MARK: - UI Elements
    @IBOutlet var buttonsCollection: [UIButton]!
    
    //MARK: - Private properties
    private var selectedType: MathTypes = .add
    /// Создадим экземпляр вспомогательного класса
    private let uiBuilder = UIBuilder()
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        /// код по конфигурированию кнопок перенесли в UIBuilder
        uiBuilder.configureButtons(buttonsCollection)
    }

    //MARK: - Actions
    @IBAction func buttonsAction(_ sender: UIButton) {
        selectedType = MathTypes(rawValue: sender.tag) ?? .add
        performSegue(withIdentifier: "goToNext", sender: sender)
    }

    @IBAction func unwindAction(unwindSegue: UIStoryboardSegue) { }

    //MARK: - Methods
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? TrainViewController {
            /// вызовем функцию для конфигурирования начального состояния контроллера
            viewController.configureInital(with: selectedType)
        }
    }
}
