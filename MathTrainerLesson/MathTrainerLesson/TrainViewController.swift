//
//  TrainViewController.swift
//  MathTrainerLesson
//
//  Created by Olya on 19.05.2024.
//

import UIKit

final class TrainViewController: UIViewController {

    //MARK: - IBOutlets

    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var counterLabel: UILabel!

    //MARK: - Properties

    /// Строитель юай элементов
    private let uiBuilder = UIBuilder()
    private var firstNumber = 0
    private var secondNumber = 0
    private var count: Int = 0
    private var totalQuestions: Int = 0
    private var correctAnswers: Int = 0
    /// Заприватили свойство, тк конфигурируем начальное состояние в функции configureInital()
    private var type: MathTypes = .add

    private var answer: Int {
        switch type {
        case .add:
            return firstNumber + secondNumber

        case .subtract:
            return firstNumber - secondNumber

        case .multiply:
            return firstNumber * secondNumber

        case .divide:
            return firstNumber / secondNumber
        }
    }
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureButtons()
        configureQuestion()
        updateCounterLabel()
    }
    
    //MARK: - IBActions
    @IBAction func leftAction(_ sender: UIButton) {
        check(answer: sender.titleLabel?.text ?? "" , for: sender)
    }
    
    @IBAction func rightAction(_ sender: UIButton) {
        check(answer: sender.titleLabel?.text ?? "" , for: sender)
    }

    //MARK: - Internal methods
    
    /// Конфигуририем начальное состояние контроллера
    func configureInital(with type: MathTypes) {
        self.type = type
        /// Добавим проверку на 0, тк нельзя делить на 0. Если тайп будет divide,
        /// установим secondNumber равным 1, иначе выйдем из функции
        guard type == .divide else { return }
        secondNumber = 1
    }

    //MARK: - Private methods

    private func configureButtons() {
        uiBuilder.configureButtons([leftButton, rightButton, backButton])
    }

    private func configureQuestion() {
        firstNumber = Int.random(in: 1...4)
        secondNumber = Int.random(in: 1...4)
        
        /// 0 невозможен, но на будущее страхуемся, вдруг коллега разработчик поменяет случайно
        if type == .divide && secondNumber == 0 {
            secondNumber = 1
        }

        let isRightButton = Bool.random()
        var randomAnswer = Int.random(in: (answer - 10)...(answer + 10))
        if randomAnswer == answer {
            randomAnswer = answer + 1 /// если сгенерируется такое же число как и правильный ответ
        }

        questionLabel.text = "\(firstNumber) \(type.stringValue) \(secondNumber) = ?"
        rightButton.setTitle(isRightButton ? String(answer) : String(randomAnswer), for: .normal)
        leftButton.setTitle(isRightButton ? String(randomAnswer) : String(answer), for: .normal)
        totalQuestions += 1
    }

    private func check(answer: String, for button: UIButton) {
            let isRightAnswer = Int(answer) == self.answer
            button.backgroundColor = isRightAnswer ? .green : .red

            if isRightAnswer {
                let isSecondAttempt = 
                rightButton.backgroundColor == .red ||
                leftButton.backgroundColor == .red
                
                if !isSecondAttempt {
                    count += 1
                    correctAnswers += 1
                }

                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { [weak self] in
                    self?.configureQuestion()
                    self?.configureButtons()
                    self?.updateCounterLabel()
                }
            } else {
                updateCounterLabel()
            }
        }

    private func updateCounterLabel() {
        counterLabel.text = "\(correctAnswers) / \(totalQuestions)"
    }
}
