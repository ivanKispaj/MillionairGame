//
//  GameSceneViewController.swift
//  Millionaire
//
//  Created by Ivan Konishchev on 05.08.2022.
//

import UIKit

class GameSceneViewController: UIViewController {

    
    weak var callFriends: UILabel!
    weak var hallHelp: UILabel!
    weak var fiftyFifty: UILabel!
    weak var totalCash: UILabel!
    weak var homeButtonImage: UIImageView!
    weak var logoImage: UIImageView!
    weak var timeCounterlabel: UILabel!
    weak var questionLabel: UILabel!
    weak var answerOne: UIButton!
    weak var answertwo: UIButton!
    weak var answerThree: UIButton!
    weak var answerFour: UIButton!
    weak var timerActivitiIntdicator: UIActivityIndicatorView!
    weak var responsePricve: UILabel!
    
    var questions = GameService.shared.getAllQuestion()
    override func viewDidLoad() {
        super.viewDidLoad()

        setupGameScene()
    }

    override var shouldAutorotate: Bool {
        return false
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    fileprivate func setupGameScene() {
        
        guard let gameSession = Game.shared.gameSession else {return}
        
        setBackgroundImage()
        let topView = setTopView(from: gameSession)
        let midlView = setMidleView(after: topView)
        let questionView = setQuestionLabel(after: midlView)
        
        setAnswerView(after: questionView, for: self.questions[0])
    }
   
}


// MARK: - setupGameScene

extension GameSceneViewController {
    
    fileprivate func setAnswerView(after questionView: UIView, for question: QuestionsModel ) {
 
        let responsePrice = UILabel(frame: .zero)
        responsePrice.text = "Сумма выигрыша: 500"
        responsePrice.textColor = UIColor(named: "goldColor")
        responsePrice.textAlignment = .center
        let answerOne = UIButton(frame: .zero)
        let answerTwo = UIButton(frame: .zero)
        let answerThree = UIButton(frame: .zero)
        let answerFour = UIButton(frame: .zero)
        answerOne.setTitle(question.answers[0], for: .normal)
        answerTwo.setTitle(question.answers[1], for: .normal)
        answerThree.setTitle(question.answers[2], for: .normal)
        answerFour.setTitle(question.answers[3], for: .normal)
        answerOne.tintColor = .white
        answerTwo.tintColor = .white
        answerThree.tintColor = .white
        answerFour.tintColor = .white
        
        answerOne.backgroundColor = UIColor.systemGray4.withAlphaComponent(0.7)
        answerTwo.backgroundColor = UIColor.systemGray4.withAlphaComponent(0.7)
        answerThree.backgroundColor = UIColor.systemGray4.withAlphaComponent(0.7)
        answerFour.backgroundColor = UIColor.systemGray4.withAlphaComponent(0.7)

        self.answerOne = answerOne
        self.answertwo = answerThree
        self.answerThree = answerThree
        self.answerFour = answerFour
        
        
        
        
        self.view.addSubview(answerOne)
        self.view.addSubview(answerTwo)
        self.view.addSubview(answerThree)
        self.view.addSubview(answerFour)
        self.view.addSubview(responsePrice)
        
        answerOne.translatesAutoresizingMaskIntoConstraints = false
        answerTwo.translatesAutoresizingMaskIntoConstraints = false
        answerThree.translatesAutoresizingMaskIntoConstraints = false
        answerFour.translatesAutoresizingMaskIntoConstraints = false
        responsePrice.translatesAutoresizingMaskIntoConstraints = false
        let answerWidht = UIScreen.main.bounds.width - 40
        
        NSLayoutConstraint.activate([
            answerOne.heightAnchor.constraint(equalToConstant: 50),
            answerTwo.heightAnchor.constraint(equalToConstant: 50),
            answerThree.heightAnchor.constraint(equalToConstant: 50),
            answerFour.heightAnchor.constraint(equalToConstant: 50),
            responsePrice.topAnchor.constraint(equalTo: questionView.bottomAnchor, constant: 20),
            responsePrice.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            
            answerOne.topAnchor.constraint(equalTo: responsePrice.bottomAnchor, constant: 50),
            self.view.bottomAnchor.constraint(greaterThanOrEqualTo: answerFour.bottomAnchor, constant: 20),
            answerOne.widthAnchor.constraint(equalToConstant: answerWidht),
            answerTwo.widthAnchor.constraint(equalToConstant: answerWidht),
            answerThree.widthAnchor.constraint(equalToConstant: answerWidht),
            answerFour.widthAnchor.constraint(equalToConstant: answerWidht),
            answerOne.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            answerTwo.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            answerThree.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            answerFour.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            answerTwo.topAnchor.constraint(equalTo: answerOne.bottomAnchor, constant: 20),
            answerThree.topAnchor.constraint(equalTo: answerTwo.bottomAnchor, constant: 20),
            answerFour.topAnchor.constraint(equalTo: answerThree.bottomAnchor, constant: 20),
            
        ])
        
    }
    
    
    fileprivate func setQuestionLabel(after midleView: UIView) -> UIView{
        var heightQuestionView: CGFloat = 10
        let questionView = UIView(frame: .zero)
        questionView.backgroundColor = UIColor(named: ColorScheme.background.rawValue)?.withAlphaComponent(0.5)
        questionView.layer.masksToBounds = false
        questionView.layer.shadowColor = UIColor.systemGray6.cgColor
        questionView.layer.shadowOpacity = 0.7
        questionView.layer.shadowOffset = CGSize(width: 0, height: 10)
        questionView.layer.shadowRadius = 6
        
        let questionLabel = UILabel(frame: .zero)
        questionLabel.textColor = .white
        questionLabel.font = UIFont.boldSystemFont(ofSize: 18)
        questionLabel.textAlignment = .left
        questionLabel.numberOfLines = 0
        questionLabel.text = self.questions[8].question
        questionView.addSubview(questionLabel)
        
        self.view.addSubview(questionView)
        questionLabel.translatesAutoresizingMaskIntoConstraints = false
        questionView.translatesAutoresizingMaskIntoConstraints = false
        
        if let height = questionLabel.getHeightLabel() {
            heightQuestionView = height
        }
        NSLayoutConstraint.activate([
            questionView.topAnchor.constraint(equalTo: midleView.bottomAnchor, constant: 30),
            questionView.heightAnchor.constraint(equalToConstant: heightQuestionView),
            questionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10),
            self.view.trailingAnchor.constraint(equalTo: questionView.trailingAnchor, constant: 10),
            
            questionLabel.topAnchor.constraint(equalTo: questionView.topAnchor, constant: 10),
            questionLabel.leadingAnchor.constraint(equalTo: questionView.leadingAnchor, constant: 0),
            questionView.trailingAnchor.constraint(equalTo: questionLabel.trailingAnchor, constant: 0),
            questionView.bottomAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 10)
        ])
        timerActivitiIntdicator.startAnimating()
        return questionView
    }

    fileprivate func setMidleView(after topView: UIView) -> UIView {
        let midleView = UIView(frame: .zero)
        midleView.backgroundColor = .clear
        self.view.addSubview(midleView)
        midleView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            midleView.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 5),
            midleView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            midleView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            midleView.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        let homeButton = UIImageView(frame: .zero)
        homeButton.translatesAutoresizingMaskIntoConstraints = false
        homeButton.image = UIImage(systemName: "house")
        homeButton.isUserInteractionEnabled = true
        let tapHomebutton = UITapGestureRecognizer(target: self, action: #selector(exitHomeScreen))
        homeButton.addGestureRecognizer(tapHomebutton)
        midleView.addSubview(homeButton)
        
        NSLayoutConstraint.activate([
            homeButton.leadingAnchor.constraint(equalTo: midleView.leadingAnchor, constant: 10),
            homeButton.centerYAnchor.constraint(equalTo: midleView.centerYAnchor),
            homeButton.heightAnchor.constraint(equalToConstant: 40),
            homeButton.widthAnchor.constraint(equalTo: homeButton.heightAnchor, multiplier:  23 / 18)
        
        ])
        let timerActiviti = UIActivityIndicatorView(frame: .zero)
        timerActiviti.color = .red
        timerActiviti.transform = CGAffineTransform(scaleX: 4, y: 4)
        
        let timeLabel = UILabel(frame: .zero)
        timeLabel.textColor = UIColor(named: ColorScheme.menuLabelColor.rawValue)
        timeLabel.font = UIFont.boldSystemFont(ofSize: 17)
        timeLabel.text = "60"
        timeLabel.backgroundColor = .clear
        timeLabel.transform = CGAffineTransform(scaleX: 0.4, y: 0.4)
        timeLabel.isHidden = false
        timerActiviti.addSubview(timeLabel)
        self.timerActivitiIntdicator = timerActiviti

        midleView.addSubview(self.timerActivitiIntdicator)
        timerActiviti.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
      
//timerActiviti.startAnimating()
        NSLayoutConstraint.activate([
            self.timerActivitiIntdicator.centerYAnchor.constraint(equalTo: midleView.centerYAnchor),
            self.timerActivitiIntdicator.centerXAnchor.constraint(equalTo: midleView.centerXAnchor),
            self.timerActivitiIntdicator.widthAnchor.constraint(equalToConstant: 100),
            self.timerActivitiIntdicator.heightAnchor.constraint(equalTo: self.timerActivitiIntdicator.widthAnchor, multiplier: 1 / 1),
            timeLabel.centerXAnchor.constraint(equalTo: self.timerActivitiIntdicator.centerXAnchor),
            timeLabel.centerYAnchor.constraint(equalTo: self.timerActivitiIntdicator.centerYAnchor)
        ])
        
        return midleView
    }
    
    fileprivate func setTopView(from gameSession: GameSessoin) -> UIView {
        let topView = UIView(frame: .zero)
        topView.backgroundColor = UIColor(named: ColorScheme.background.rawValue)
    
 // Hints (Подсказки)
        let callFriendsImage = UIImageView(frame: .zero)
        let hallHelpImage = UIImageView(frame: .zero)
        let fiftyFiftyImage = UIImageView(frame: .zero)
        let callFriends = UILabel(frame: .zero)
        let hallHelp = UILabel(frame: .zero)
        let fiftyFifty = UILabel(frame: .zero)
        
        self.hallHelp = hallHelp
        self.fiftyFifty = fiftyFifty
        self.callFriends = callFriends
        fiftyFifty.font = UIFont.systemFont(ofSize: 12)
        fiftyFifty.text = String(gameSession.numberOfHints.fiftyFifty)
        fiftyFifty.textColor = .red
        
        hallHelp.font = UIFont.systemFont(ofSize: 12)
        hallHelp.text = String(gameSession.numberOfHints.hallHelp)
        hallHelp.textColor = .red
        
        
        callFriends.font = UIFont.systemFont(ofSize: 12)
        callFriends.text = String(gameSession.numberOfHints.callToFriends)
        callFriends.textColor = .red
        
        callFriendsImage.addSubview(callFriends)
        hallHelpImage.addSubview(hallHelp)
        fiftyFiftyImage.addSubview(fiftyFifty)
        
 // картинки подсказок
        hallHelpImage.image = UIImage(systemName: "person.3.fill")
        callFriendsImage.image = UIImage(systemName: "phone.and.waveform.fill")
        fiftyFiftyImage.image = UIImage(named: "fiftyFifty")
        
 // TotalCash (Заработанные деньги)
        let totalCashImage = UIImageView(frame: .zero)
        let totalCashLabel = UILabel(frame: .zero)
        totalCashImage.image = UIImage(named: "Money")
        totalCashLabel.text = String(gameSession.totalCash)
        totalCashLabel.textColor = UIColor(named: ColorScheme.menuLabelColor.rawValue)
        totalCashLabel.font = UIFont.systemFont(ofSize: 12)
        
        topView.translatesAutoresizingMaskIntoConstraints = false
        callFriendsImage.translatesAutoresizingMaskIntoConstraints = false
        hallHelpImage.translatesAutoresizingMaskIntoConstraints = false
        fiftyFiftyImage.translatesAutoresizingMaskIntoConstraints = false
        totalCashLabel.translatesAutoresizingMaskIntoConstraints = false
        totalCashImage.translatesAutoresizingMaskIntoConstraints = false
        hallHelp.translatesAutoresizingMaskIntoConstraints = false
        fiftyFifty.translatesAutoresizingMaskIntoConstraints = false
        callFriends.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(topView)
        topView.addSubview(totalCashImage)
        topView.addSubview(totalCashLabel)
        topView.addSubview(callFriendsImage)
        topView.addSubview(fiftyFiftyImage)
        topView.addSubview(hallHelpImage)

// констрейнты для верхнего бара (topView)
        NSLayoutConstraint.activate([
            self.view.leadingAnchor.constraint(equalTo: topView.leadingAnchor),
            topView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            topView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            topView.heightAnchor.constraint(equalToConstant: 50),
            totalCashImage.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: 10),
            totalCashImage.centerYAnchor.constraint(equalTo: topView.centerYAnchor),
            totalCashLabel.leadingAnchor.constraint(equalTo: totalCashImage.trailingAnchor, constant: 5),
            totalCashLabel.centerYAnchor.constraint(equalTo: topView.centerYAnchor),
            callFriendsImage.centerYAnchor.constraint(equalTo: topView.centerYAnchor),
            topView.trailingAnchor.constraint(equalTo: callFriendsImage.trailingAnchor, constant: 15),
            callFriendsImage.leadingAnchor.constraint(equalTo: fiftyFiftyImage.trailingAnchor, constant: 15),
            fiftyFiftyImage.centerYAnchor.constraint(equalTo: topView.centerYAnchor),
            fiftyFiftyImage.leadingAnchor.constraint(equalTo: hallHelpImage.trailingAnchor, constant: 15),
            hallHelpImage.centerYAnchor.constraint(equalTo: topView.centerYAnchor),
            hallHelpImage.leadingAnchor.constraint(greaterThanOrEqualTo: totalCashLabel.trailingAnchor, constant: 10),
            totalCashImage.widthAnchor.constraint(equalToConstant: 30),
            totalCashLabel.widthAnchor.constraint(equalToConstant: 40),
            callFriendsImage.widthAnchor.constraint(equalToConstant: 30),
            hallHelpImage.widthAnchor.constraint(equalToConstant: 50),
            fiftyFiftyImage.widthAnchor.constraint(equalToConstant: 50),
            callFriendsImage.heightAnchor.constraint(equalTo: callFriendsImage.widthAnchor, multiplier: 1 / 1),
            hallHelpImage.heightAnchor.constraint(equalTo: hallHelpImage.widthAnchor, multiplier: 9 / 16),
            fiftyFiftyImage.heightAnchor.constraint(equalTo: fiftyFiftyImage.widthAnchor, multiplier: 9 / 16),
            fiftyFifty.bottomAnchor.constraint(equalTo: fiftyFiftyImage.bottomAnchor, constant: 8),
            fiftyFifty.leadingAnchor.constraint(equalTo: fiftyFiftyImage.leadingAnchor, constant: 40),
            fiftyFifty.trailingAnchor.constraint(greaterThanOrEqualTo: fiftyFiftyImage.trailingAnchor, constant: -10),
            fiftyFifty.topAnchor.constraint(greaterThanOrEqualTo: fiftyFiftyImage.topAnchor, constant: 0),
            hallHelp.bottomAnchor.constraint(equalTo: hallHelpImage.bottomAnchor, constant: 8),
            hallHelp.leadingAnchor.constraint(equalTo: hallHelpImage.leadingAnchor, constant: 40),
            hallHelp.trailingAnchor.constraint(greaterThanOrEqualTo: hallHelpImage.trailingAnchor, constant: -10),
            hallHelp.topAnchor.constraint(greaterThanOrEqualTo: hallHelpImage.topAnchor, constant: 0),
            callFriends.bottomAnchor.constraint(equalTo: callFriendsImage.bottomAnchor, constant: 8),
            callFriends.leadingAnchor.constraint(equalTo: callFriendsImage.leadingAnchor, constant: 30),
            callFriends.trailingAnchor.constraint(greaterThanOrEqualTo: callFriendsImage.trailingAnchor, constant: 5),
            callFriends.topAnchor.constraint(greaterThanOrEqualTo: callFriendsImage.topAnchor, constant: 0)
            
        ])
        return topView
    }
    
    fileprivate func setBackgroundImage() {
        self.view.backgroundColor = UIColor(named: ColorScheme.background.rawValue)
        let backgroundImage = UIImageView(frame: .zero)
        backgroundImage.image = UIImage(named: "MillionairLogo")
        backgroundImage.layer.opacity = 0.4
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(backgroundImage)
        NSLayoutConstraint.activate([
            backgroundImage.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            backgroundImage.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            backgroundImage.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            backgroundImage.heightAnchor.constraint(equalTo: backgroundImage.widthAnchor, multiplier: 9 / 16)
        ])
    }
    
    //MARK: - Exit Home Screen
    
    @objc func exitHomeScreen() {
        self.dismiss(animated: true)
    }
}
