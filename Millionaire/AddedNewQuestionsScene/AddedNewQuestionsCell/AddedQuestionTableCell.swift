//
//  AddedQuestionTableCell.swift
//  Millionaire
//
//  Created by Ivan Konishchev on 12.08.2022.
//

import UIKit

class AddedQuestionTableCell: UITableViewCell, UITextViewDelegate  {
    
    @IBOutlet weak var textViewQuestion: UITextView!
    @IBOutlet weak var textViewAnswers: UITextView!
    @IBOutlet weak var textViewDescription: UITextView!
    @IBOutlet weak var buttonRightAnswerNumber: UIButton!
    @IBOutlet weak var buttonDifficulty: UIButton!
    weak var questionBuilder: QuestionBuilder!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let tap = UITapGestureRecognizer(target: self, action: #selector(firstResponderResign))
        let tapDiff = UITapGestureRecognizer(target: self, action: #selector(firstResponderResign))
        buttonRightAnswerNumber.addGestureRecognizer(tap)
        buttonDifficulty.addGestureRecognizer(tapDiff)
        self.backgroundColor = UIColor(named: ColorScheme.background.rawValue)
        textViewQuestion.delegate = self
        textViewAnswers.delegate = self
        textViewDescription.delegate = self
        textViewQuestion.tag = 0
        textViewAnswers.tag = 1
        textViewDescription.tag = 2
        setButtonData()
    }
    
    @objc func firstResponderResign() {
        textViewAnswers.resignFirstResponder()
        textViewQuestion.resignFirstResponder()
        textViewDescription.resignFirstResponder()
    }
    func configureCell(with indexPath: IndexPath, questionBuilder: QuestionBuilder?) {
        guard let builder = questionBuilder else { return }
        self.tag = indexPath.row
        self.questionBuilder = builder
        if builder.allAddedQuestions.count > 0 {
            textViewQuestion.text = builder.allAddedQuestions[indexPath.row].question
            print(builder.allAddedQuestions[indexPath.row].answers.count)
            if builder.allAddedQuestions[indexPath.row].answers.count != 0 {
                textViewAnswers.text = builder.allAddedQuestions[indexPath.row].answers.joined(separator: ",")
            } else {
                textViewAnswers.text = "Введите четыре ответа через запятую..."
            }
            
            textViewDescription.text = builder.allAddedQuestions[indexPath.row].description
            
            if builder.rightAnswer == "" {
                buttonRightAnswerNumber.setTitle("Номер правильного ответа", for: .normal)
            } else {
                buttonRightAnswerNumber.setTitle(String(builder.getRightQuestionNumber(toCell: indexPath.row)), for: .normal)

            }
            
            if builder.allAddedQuestions[indexPath.row].difficultyLevel == 0 {
                buttonDifficulty.setTitle("Сложность вопроса 1...15", for: .normal)
            } else {
                buttonDifficulty.setTitle(String(builder.allAddedQuestions[indexPath.row].difficultyLevel ), for: .normal)

            }
        }
        
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        switch textView.tag {
        case 0:
            if textView.text == "Введите ваш вопрос..." {
                textView.text = ""
                textView.textColor = .white
            }
        case 1:
            if textView.text == "Введите четыре ответа через запятую..." {
                textView.text = ""
                textView.textColor = .white
            }
        case 2:
            if textView.text == "Введите описание ответа, если есть..." {
                textView.text = ""
                textView.textColor = .white
            }
        default:
            return
        }
        
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        switch textView.tag {
        case 0:
            if textView.text == "" {
                textView.textColor = .systemGray6
                textView.text = "Введите ваш вопрос..."
                
            } else {
                questionBuilder.setQuestion(toCell: self.tag, textView.text)
            }
            
        case 1:
            if textView.text == "" || textView.text.components(separatedBy: ",").count < 4 {
                textView.textColor = .systemGray6
                textView.text = "Введите четыре ответа через запятую..."
            } else {
                questionBuilder.setAnswers(toCell: self.tag, textView.text)
            }
            
        case 2:
            if textView.text == "" {
                textView.textColor = .systemGray6
                textView.text = "Введите описание ответа, если есть..."
            } else {
                questionBuilder.setDescription(toCell: self.tag, textView.description)
            }
            
        default:
            return
        }
       
     
        
    }
    
    
    func setButtonData() {
        // button right answers number
        let oneAction = UIAction(title: "1") { (number) in
            self.questionBuilder.setRightAnswer(toCell: self.tag, Int(number.title) ?? 1)
            self.buttonRightAnswerNumber.setTitle(number.title, for: .normal)
                                                 }
        
        let twoAction = UIAction(title: "2") { (number) in
            self.questionBuilder.setRightAnswer(toCell: self.tag, Int(number.title) ?? 2)
            self.buttonRightAnswerNumber.setTitle(number.title, for: .normal)
         }
        
        let threeAction = UIAction(title: "3") { (number) in
            self.questionBuilder.setRightAnswer(toCell: self.tag, Int(number.title) ?? 3)
            self.buttonRightAnswerNumber.setTitle(number.title, for: .normal)
         }
        
        let fourAction = UIAction(title: "4") { (number) in
            self.questionBuilder.setRightAnswer(toCell: self.tag, Int(number.title) ?? 4)
            self.buttonRightAnswerNumber.setTitle(number.title, for: .normal)
         }
        self.buttonRightAnswerNumber.menu = UIMenu(title: "", options: .destructive, children: [oneAction,twoAction,threeAction,fourAction])
  
        //Button difficulty options
        let difficulty1 = UIAction(title: "1") { (number) in
            self.questionBuilder.setDifficulty(toCell: self.tag, Int(number.title) ?? 1)
            self.buttonDifficulty.setTitle(number.title, for: .normal)
                                                 }
        let difficulty2 = UIAction(title: "2") { (number) in
            self.questionBuilder.setDifficulty(toCell: self.tag, Int(number.title) ?? 1)
            self.buttonDifficulty.setTitle(number.title, for: .normal)
                                                 }
        let difficulty3 = UIAction(title: "3") { (number) in
            self.questionBuilder.setDifficulty(toCell: self.tag, Int(number.title) ?? 1)
            self.buttonDifficulty.setTitle(number.title, for: .normal)
                                                 }
        let difficulty4 = UIAction(title: "4") { (number) in
            self.questionBuilder.setDifficulty(toCell: self.tag, Int(number.title) ?? 1)
            self.buttonDifficulty.setTitle(number.title, for: .normal)
                                                 }
        let difficulty5 = UIAction(title: "5") { (number) in
            self.questionBuilder.setDifficulty(toCell: self.tag, Int(number.title) ?? 1)
            self.buttonDifficulty.setTitle(number.title, for: .normal)
                                                 }
        let difficulty6 = UIAction(title: "6") { (number) in
            self.questionBuilder.setDifficulty(toCell: self.tag, Int(number.title) ?? 1)
            self.buttonDifficulty.setTitle(number.title, for: .normal)
                                                 }
        let difficulty7 = UIAction(title: "7") { (number) in
            self.questionBuilder.setDifficulty(toCell: self.tag, Int(number.title) ?? 1)
            self.buttonDifficulty.setTitle(number.title, for: .normal)
                                                 }
        let difficulty8 = UIAction(title: "8") { (number) in
            self.questionBuilder.setDifficulty(toCell: self.tag, Int(number.title) ?? 1)
            self.buttonDifficulty.setTitle(number.title, for: .normal)
                                                 }
        let difficulty9 = UIAction(title: "9") { (number) in
            self.questionBuilder.setDifficulty(toCell: self.tag, Int(number.title) ?? 1)
            self.buttonDifficulty.setTitle(number.title, for: .normal)
                                                 }
        let difficulty10 = UIAction(title: "10") { (number) in
            self.questionBuilder.setDifficulty(toCell: self.tag, Int(number.title) ?? 1)
            self.buttonDifficulty.setTitle(number.title, for: .normal)
                                                 }
        let difficulty11 = UIAction(title: "11") { (number) in
            self.questionBuilder.setDifficulty(toCell: self.tag, Int(number.title) ?? 1)
            self.buttonDifficulty.setTitle(number.title, for: .normal)
                                                 }
        let difficulty12 = UIAction(title: "12") { (number) in
            self.questionBuilder.setDifficulty(toCell: self.tag, Int(number.title) ?? 1)
            self.buttonDifficulty.setTitle(number.title, for: .normal)
                                                 }
        let difficulty13 = UIAction(title: "13") { (number) in
            self.questionBuilder.setDifficulty(toCell: self.tag, Int(number.title) ?? 1)
            self.buttonDifficulty.setTitle(number.title, for: .normal)
                                                 }
        let difficulty14 = UIAction(title: "14") { (number) in
            self.questionBuilder.setDifficulty(toCell: self.tag, Int(number.title) ?? 1)
            self.buttonDifficulty.setTitle(number.title, for: .normal)
                                                 }
        let difficulty15 = UIAction(title: "15") { (number) in
            self.questionBuilder.setDifficulty(toCell: self.tag, Int(number.title) ?? 1)
            self.buttonDifficulty.setTitle(number.title, for: .normal)
                                                 }
        self.buttonDifficulty.menu = UIMenu(title: "", options: .destructive, children: [
            difficulty1,difficulty2,difficulty3,difficulty4,difficulty5,difficulty6,difficulty7,difficulty8,difficulty9,difficulty10,difficulty11,difficulty12,difficulty13,difficulty14,difficulty15
        ])
    }
}
