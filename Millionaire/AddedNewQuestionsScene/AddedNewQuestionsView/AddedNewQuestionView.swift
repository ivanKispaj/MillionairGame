//
//  AddedNewQuestionView.swift
//  Millionaire
//
//  Created by Ivan Konishchev on 12.08.2022.
//

import UIKit

class AddedNewQuestionView: UIViewController {

    var questionBuilder: QuestionBuilder?
    var caretacker: QuestionsCareTaker?
    weak var myTableView: UITableView!
    
    var numberOfQuestions: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.caretacker = QuestionsCareTaker()
        self.questionBuilder = QuestionBuilder()
        setViewSubview()
        myTableView.register(UINib(nibName: "AddedQuestionTableCell", bundle: nil), forCellReuseIdentifier: "MyCell")

    }
  
}


extension AddedNewQuestionView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.numberOfQuestions
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell") as? AddedQuestionTableCell else {
            preconditionFailure("Error cell")
        }
        cell.configureCell(with: indexPath, questionBuilder: self.questionBuilder)
        return cell
    }
    

}

//MARK: - Exit to mainMenu
extension AddedNewQuestionView {
    @objc func backHome() {
        self.dismiss(animated: true)
    }
}


//MARK: - set view subview
extension AddedNewQuestionView {
    
    private func setViewSubview() {
        self.view.backgroundColor = UIColor(named: ColorScheme.background.rawValue)
        
        //button back to main menu
        let backButton = UIImageView(frame: .zero)
        backButton.image = UIImage(systemName: "arrowshape.turn.up.left.fill")
        backButton.tintColor = .white//UIColor(named: ColorScheme.tabBarColor.rawValue)
        let tap = UITapGestureRecognizer(target: self, action: #selector(backHome))
        backButton.isUserInteractionEnabled = true
        backButton.addGestureRecognizer(tap)
        self.view.addSubview(backButton)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        // tableView
        let table = UITableView(frame: .zero)
        table.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(table)
        self.myTableView = table
        myTableView.backgroundColor = UIColor(named: ColorScheme.background.rawValue)
        table.delegate = self
        table.dataSource = self
        
        NSLayoutConstraint.activate([
            myTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            myTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
           // myTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
        
        NSLayoutConstraint.activate([
            backButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10),
            backButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 50),
            myTableView.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 20),
            backButton.heightAnchor.constraint(equalToConstant: 30),
            backButton.widthAnchor.constraint(equalTo: backButton.heightAnchor, multiplier: 1 / 1),
            self.view.trailingAnchor.constraint(greaterThanOrEqualTo: backButton.trailingAnchor, constant: 0)
        ])
        
        let saveButton = getButton(withTitle: "Сохранитть", systemImage: "tray.and.arrow.down.fill", tag: 0)
        let addButton = getButton(withTitle: "Добавитьт", systemImage: "plus.bubble.fill", tag: 1)
        let bottomView = UIView(frame: .zero)
        
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        bottomView.addSubview(saveButton)
        bottomView.addSubview(addButton)
        
        self.view.addSubview(bottomView)
        NSLayoutConstraint.activate([
            bottomView.topAnchor.constraint(equalTo: self.myTableView.bottomAnchor, constant: 10),
            bottomView.heightAnchor.constraint(equalToConstant: 80),
            bottomView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.view.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor,constant: 30),
            saveButton.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 10),
            saveButton.centerYAnchor.constraint(equalTo: bottomView.centerYAnchor),
            saveButton.widthAnchor.constraint(equalToConstant: 140),
            addButton.centerYAnchor.constraint(equalTo: bottomView.centerYAnchor),
            addButton.leadingAnchor.constraint(greaterThanOrEqualTo: saveButton.trailingAnchor),
            addButton.widthAnchor.constraint(equalToConstant: 140),
            addButton.heightAnchor.constraint(equalToConstant: 40),
            bottomView.trailingAnchor.constraint(equalTo: addButton.trailingAnchor, constant: 10),
            saveButton.heightAnchor.constraint(equalToConstant: 40)
            
        ])
    }
    
    func getButton(withTitle title: String, systemImage name: String, tag: Int) -> UIButton {
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapToActionButton))
        let button = UIButton(frame: .zero)
        button.tag = tag
        button.setImage(UIImage(systemName: name), for: .normal)
        button.setTitle(title, for: .normal)
        button.addGestureRecognizer(tap)
        button.isUserInteractionEnabled = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.borderWidth = 1.5
        button.layer.borderColor = UIColor(named: ColorScheme.goldColor.rawValue)?.cgColor
        button.layer.cornerRadius = 5
        
        return button
    }
}

extension AddedNewQuestionView {
    @objc func tapToActionButton(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
        guard let senderView = sender.view else { return }
        switch senderView.tag {
        case 0:
            if let builder = self.questionBuilder, builder.build() {
                self.caretacker?.saveQuestions(questions: builder.allQuestions)
                self.dismiss(animated: true)
            }
            
        case 1:
            if let builder = self.questionBuilder, builder.build() {
                self.numberOfQuestions += 1
                self.myTableView.reloadData()
            }
           
        default:
            break
        }
    }
}
