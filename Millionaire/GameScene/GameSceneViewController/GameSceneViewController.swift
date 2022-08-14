//
//  GameSceneViewController.swift
//  Millionaire
//
//  Created by Ivan Konishchev on 05.08.2022.
//

import UIKit

protocol GameSceneDelegate: AnyObject {
    func didEndGame(withResult result: Int, rightAnswer: Int)
}

class GameSceneViewController: UIViewController, UIScrollViewDelegate {
    
    
    weak var endGameDelegate: GameSceneDelegate?
    var questionHeighConstreint: NSLayoutConstraint!
    weak var scrollView: UIScrollView!
    weak var questionView: UIView!
    weak var callFriends: UILabel!
    weak var hallHelp: UILabel!
    weak var fiftyFifty: UILabel!
    weak var totalCash: UILabel!
    weak var homeButtonImage: UIImageView!
    weak var logoImage: UIImageView!
    weak var timeCounterlabel: UILabel!
    weak var questionLabel: UILabel!
    weak var answerOne: UIButton!
    weak var answerTwo: UIButton!
    weak var answerThree: UIButton!
    weak var answerFour: UIButton!
    weak var timerActivitiIntdicator: UIActivityIndicatorView!
    weak var timerActivitiLabel: UILabel!
    weak var responsePrice: UILabel!
    var gameTime: Int = 0
    var countdown = 0
    var timer: Timer?
    var currentLevel: Int = 0
    weak var questionNumber: UILabel!
    weak var currentQuestion: QuestionsModel?
    var allQuestions: [QuestionsModel] = []
    var questionPrice = [500,1000,2000,3000,5000,10000,15000,25000,50000,100000,200000,400000,800000,1500000,3000000]
    var difficultyLevel: DifficultyLevel = .easy
    
    private var difficultyFacade: DifficultyGameFacade?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let questions = QuestionsCareTaker().loadQuestions() {
            self.allQuestions = questions
        } 
        endGameDelegate = Game.shared.gameSession

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.currentLevel = 0
        self.difficultyFacade = DifficultyGameFacade(difficulty: self.difficultyLevel)
        difficultyFacade?.setLevelDifficulty(fromGameScene: self)
        self.currentQuestion = allQuestions[currentLevel]
        setupGameScene()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(oneSeconds), userInfo: nil, repeats: true)
        self.timerActivitiIntdicator.startAnimating()
        timer?.fire()
        
        
    }
    
    // Отключаем автоповорот экрана
    override var shouldAutorotate: Bool {
        return false
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    
    
    fileprivate func setupGameScene() {
        
        setBackgroundImage()
        let topView = setTopView()
        let midlView = setMiddleView(after: topView)
        let questionView = setQuestionLabel(after: midlView)
        setAnswerView(after: questionView)
        setlableAndButtontitle()
    }
    
}


// MARK: - setupGameScene

extension GameSceneViewController {
    //MARK: - answer view
    fileprivate func setAnswerView(after questionView: UIView) {
        let difficult = UILabel(frame: .zero)
        difficult.text = "Сложность - \(difficultyLevel.rawValue)"
        difficult.font = UIFont.boldSystemFont(ofSize: 12)
        difficult.textColor = .red
        difficult.translatesAutoresizingMaskIntoConstraints = false
        self.scrollView.addSubview(difficult)
        
        let responsePrice = UILabel(frame: .zero)
        responsePrice.textColor = UIColor(named: "goldColor")
        responsePrice.textAlignment = .center
        self.responsePrice = responsePrice
        
        let answerOne = getButton()
        let answerTwo = getButton()
        let answerThree = getButton()
        let answerFour = getButton()
        
        self.answerOne = answerOne
        self.answerTwo = answerTwo
        self.answerThree = answerThree
        self.answerFour = answerFour
        
        self.scrollView.addSubview(answerOne)
        self.scrollView.addSubview(answerTwo)
        self.scrollView.addSubview(answerThree)
        self.scrollView.addSubview(answerFour)
        self.scrollView.addSubview(responsePrice)
        
        responsePrice.translatesAutoresizingMaskIntoConstraints = false
        let answerWidht = UIScreen.main.bounds.width - 40
        
        NSLayoutConstraint.activate([
            answerOne.heightAnchor.constraint(equalToConstant: 50),
            answerTwo.heightAnchor.constraint(equalToConstant: 50),
            answerThree.heightAnchor.constraint(equalToConstant: 50),
            answerFour.heightAnchor.constraint(equalToConstant: 50),
            difficult.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor),
            difficult.topAnchor.constraint(equalTo: questionView.bottomAnchor, constant: 20),
            responsePrice.topAnchor.constraint(equalTo: difficult.bottomAnchor, constant: 10),
            responsePrice.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor),
            answerOne.topAnchor.constraint(equalTo: responsePrice.bottomAnchor, constant: 50),
            self.scrollView.bottomAnchor.constraint(greaterThanOrEqualTo: answerFour.bottomAnchor, constant: 20),
            answerOne.widthAnchor.constraint(equalToConstant: answerWidht),
            answerTwo.widthAnchor.constraint(equalToConstant: answerWidht),
            answerThree.widthAnchor.constraint(equalToConstant: answerWidht),
            answerFour.widthAnchor.constraint(equalToConstant: answerWidht),
            answerOne.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor),
            answerTwo.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor),
            answerThree.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor),
            answerFour.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor),
            answerTwo.topAnchor.constraint(equalTo: answerOne.bottomAnchor, constant: 20),
            answerThree.topAnchor.constraint(equalTo: answerTwo.bottomAnchor, constant: 20),
            answerFour.topAnchor.constraint(equalTo: answerThree.bottomAnchor, constant: 20),
            
        ])
        
    }
    
    //MARK: - Questions label
    
    fileprivate func setQuestionLabel(after midleView: UIView) -> UIView{
        let questionNumber = UILabel(frame: .zero)
        questionNumber.textColor = UIColor(named: ColorScheme.buttonAnswer.rawValue)
        questionNumber.font = UIFont.boldSystemFont(ofSize: 20)
        questionNumber.textAlignment = .center
        self.scrollView.addSubview(questionNumber)
        self.questionNumber = questionNumber
        
        let questionView = UIView(frame: .zero)
        questionView.backgroundColor = UIColor(named: ColorScheme.background.rawValue)?.withAlphaComponent(0.5)
        questionView.layer.masksToBounds = false
        questionView.layer.shadowColor = UIColor.systemGray6.cgColor
        questionView.layer.shadowOpacity = 0.7
        questionView.layer.shadowOffset = CGSize(width: 0, height: 10)
        questionView.layer.shadowRadius = 6
        self.scrollView.addSubview(questionView)

        let questionLabel = UILabel(frame: .zero)
        questionLabel.textColor = .white
        questionLabel.font = UIFont.boldSystemFont(ofSize: 18)
        questionLabel.textAlignment = .left
        questionLabel.numberOfLines = 0
        questionView.addSubview(questionLabel)
        questionLabel.translatesAutoresizingMaskIntoConstraints = false
        questionView.translatesAutoresizingMaskIntoConstraints = false
        questionNumber.translatesAutoresizingMaskIntoConstraints = false
        
        self.questionHeighConstreint = questionView.heightAnchor.constraint(equalToConstant: 10)
        self.questionLabel = questionLabel
        self.questionView = questionView
        
        NSLayoutConstraint.activate([
            questionNumber.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor),
            questionNumber.topAnchor.constraint(equalTo: midleView.bottomAnchor, constant: 20),
            questionView.widthAnchor.constraint(equalToConstant: self.view.frame.maxX - 20),
            questionView.topAnchor.constraint(equalTo: questionNumber.bottomAnchor, constant: 10),
            questionView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor, constant: 10),
            self.scrollView.trailingAnchor.constraint(equalTo: questionView.trailingAnchor, constant: 10),
            questionLabel.topAnchor.constraint(equalTo: questionView.topAnchor, constant: 10),
            questionLabel.leadingAnchor.constraint(equalTo: questionView.leadingAnchor, constant: 0),
            questionView.trailingAnchor.constraint(equalTo: questionLabel.trailingAnchor, constant: 0),
            questionView.bottomAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 10)
        ])
        return questionView
    }
    
    
    //MARK: - Middle view (home button and game timer)
    fileprivate func setMiddleView(after topView: UIView) -> UIView {
        let midleView = UIView(frame: .zero)
        midleView.backgroundColor = .clear
        self.scrollView.addSubview(midleView)
        midleView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            midleView.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 5),
            midleView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor),
            midleView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor),
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
        timeLabel.backgroundColor = .clear
        timeLabel.transform = CGAffineTransform(scaleX: 0.4, y: 0.4)
        timeLabel.isHidden = false
        timerActiviti.addSubview(timeLabel)
        self.timerActivitiIntdicator = timerActiviti
        self.timerActivitiLabel = timeLabel
        midleView.addSubview(self.timerActivitiIntdicator)
        timerActiviti.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.timerActivitiIntdicator.centerYAnchor.constraint(equalTo: midleView.centerYAnchor),
            self.timerActivitiIntdicator.centerXAnchor.constraint(equalTo: midleView.centerXAnchor),
            self.timerActivitiIntdicator.heightAnchor.constraint(equalTo: self.timerActivitiIntdicator.widthAnchor, multiplier: 1 / 1),
            timeLabel.centerXAnchor.constraint(equalTo: self.timerActivitiIntdicator.centerXAnchor),
            timeLabel.centerYAnchor.constraint(equalTo: self.timerActivitiIntdicator.centerYAnchor)
        ])
        
        return midleView
    }
    
    //MARK: - top view ( total cash and hints)
    fileprivate func setTopView() -> UIView {
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
        fiftyFifty.textColor = .red
        
        hallHelp.font = UIFont.systemFont(ofSize: 12)
        hallHelp.textColor = .red
        
        
        callFriends.font = UIFont.systemFont(ofSize: 12)
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
        totalCashLabel.textColor = UIColor(named: ColorScheme.menuLabelColor.rawValue)
        totalCashLabel.font = UIFont.systemFont(ofSize: 12)
        self.totalCash = totalCashLabel
        
        topView.translatesAutoresizingMaskIntoConstraints = false
        callFriendsImage.translatesAutoresizingMaskIntoConstraints = false
        hallHelpImage.translatesAutoresizingMaskIntoConstraints = false
        fiftyFiftyImage.translatesAutoresizingMaskIntoConstraints = false
        totalCashLabel.translatesAutoresizingMaskIntoConstraints = false
        totalCashImage.translatesAutoresizingMaskIntoConstraints = false
        hallHelp.translatesAutoresizingMaskIntoConstraints = false
        fiftyFifty.translatesAutoresizingMaskIntoConstraints = false
        callFriends.translatesAutoresizingMaskIntoConstraints = false
        
        self.scrollView.addSubview(topView)
        topView.addSubview(totalCashImage)
        topView.addSubview(totalCashLabel)
        topView.addSubview(callFriendsImage)
        topView.addSubview(fiftyFiftyImage)
        topView.addSubview(hallHelpImage)
        
        // констрейнты для верхнего бара (topView)
        NSLayoutConstraint.activate([
            self.scrollView.leadingAnchor.constraint(equalTo: topView.leadingAnchor),
            topView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor),
            topView.topAnchor.constraint(equalTo: self.scrollView.topAnchor,constant: 20),
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
            totalCashLabel.widthAnchor.constraint(equalToConstant: 100),
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
    
    //MARK: - background image
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
        
        let scrollView = UIScrollView(frame: .zero)
        scrollView.backgroundColor = .clear
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(scrollView)
        scrollView.contentMode = .center
        self.scrollView = scrollView
        self.scrollView.showsHorizontalScrollIndicator = false
        self.scrollView.frame = self.view.safeAreaLayoutGuide.layoutFrame
        NSLayoutConstraint.activate([
            self.scrollView.widthAnchor.constraint(equalTo: self.view.widthAnchor),
            self.scrollView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
    
    //MARK: - Create UIbutton for Answer
    fileprivate     func getButton() -> UIButton {
        let button = UIButton(frame: .zero)
        button.tintColor = UIColor(named: ColorScheme.buttonAnswer.rawValue)
        button.backgroundColor = UIColor(named: ColorScheme.buttonAnswerBackground.rawValue)?.withAlphaComponent(0.7)
        button.layer.cornerRadius = 10
        button.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapAnswer))
        button.addGestureRecognizer(tap)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
    
    //MARK: - Exit Home Screen
    
    @objc func exitHomeScreen() {
        self.timer?.invalidate()
        self.timer = nil
        Game.shared.gameSession = nil
        self.dismiss(animated: true)
    }
    
    //MARK: - Timer
    @objc func oneSeconds() {
        guard let gameSession = Game.shared.gameSession else { return }
        
        self.countdown = self.countdown - 1
   
        if self.countdown <= 0 {
            self.timer?.invalidate()
            self.timerActivitiIntdicator.stopAnimating()
            endGameDelegate?.didEndGame(withResult: gameSession.totalCash, rightAnswer: self.currentLevel + 1)
            self.dismiss(animated: true)
        }
        self.timerActivitiLabel.text = String(countdown)
    }
    
    // MARK: - Обработка нажатия на ответ
    @objc func tapAnswer(_ sender: UITapGestureRecognizer) {
        guard let question = self.currentQuestion else { return }
        guard let gameSession = Game.shared.gameSession else {return}
        
        if let buttonRecognaizer = sender.view as? UIButton, let titleButton = buttonRecognaizer.title(for: .normal) {
            
            if question.rightAnswer == titleButton {
                gameSession.totalCash = self.questionPrice[self.currentLevel]
                self.currentLevel = self.currentLevel + 1
                
                if let description = question.description {
                    self.timerActivitiIntdicator.stopAnimating()
                    let alert = UIAlertController(title: "Поздравляем! Верный ответ.", message: description, preferredStyle: .alert)
                    let action = UIAlertAction(title: "Ok", style: .default) { action in
                        self.timerActivitiIntdicator.startAnimating()
                        if self.currentLevel <= 14 {
                            self.countdown = self.gameTime
                            self.currentQuestion = self.allQuestions[self.currentLevel]
                            self.setlableAndButtontitle()
                        } else {
                            self.timerActivitiIntdicator.stopAnimating()
                            self.endGameDelegate?.didEndGame(withResult: self.questionPrice[self.currentLevel - 1], rightAnswer: self.currentLevel)
                            
                            let alertEndGame = UIAlertController(title: "Поздравляем!", message: "Вы выиграли, и ответили на все вопросы! Попробуйте еще раз.", preferredStyle: .alert)
                            let actionOk = UIAlertAction(title: "Ok", style: .default) { _ in
                                
                                self.timer?.invalidate()
                                self.timer = nil
                                Game.shared.gameSession = nil
                                self.dismiss(animated: true)
                            }
                            
                            alertEndGame.addAction(actionOk)
                            self.present(alertEndGame, animated: true)
                        }
                    }
                    
                    alert.addAction(action)
                    self.present(alert, animated: true)
                    
                } else {
                    if self.currentLevel <= 14 {
                        setlableAndButtontitle()
                        self.countdown = self.gameTime
                    }
                }
                
            } else {
                if self.currentLevel == 0 {
                    endGameDelegate?.didEndGame(withResult: 0, rightAnswer: 0)
                } else {
                    endGameDelegate?.didEndGame(withResult: self.questionPrice[self.currentLevel - 1], rightAnswer: self.currentLevel)
                    
                }
                if let description = question.description {
                    self.timerActivitiIntdicator.stopAnimating()
                    self.timer = nil
                    
                    let alert = UIAlertController(title: "Не верный ответ!", message: description, preferredStyle: .alert)
                    let action = UIAlertAction(title: "Ok", style: .default) { _ in
                        Game.shared.gameSession = nil
                        self.dismiss(animated: true)
                    }
                    
                    alert.addAction(action)
                    self.present(alert, animated: true)
                } else {
                    Game.shared.gameSession = nil
                    self.dismiss(animated: true)
                }
                
                
            }
        }
        
    }
    
    //MARK: - set label and button text
    fileprivate func setlableAndButtontitle() {
        guard let question = self.currentQuestion else {return}
        guard let gameSession = Game.shared.gameSession else {return}
        
        responsePrice.text = "Баллов за ответ:  \(String(self.questionPrice[self.currentLevel]))"
        
        self.answerOne.setTitle(question.answers[0], for: .normal)
        self.answerTwo.setTitle(question.answers[1], for: .normal)
        self.answerThree.setTitle(question.answers[2], for: .normal)
        self.answerFour.setTitle(question.answers[3], for: .normal)
        self.questionLabel.text = question.question
        self.timerActivitiLabel.text = String(countdown)
        self.fiftyFifty.text = String(gameSession.numberOfHints.fiftyFifty)
        self.hallHelp.text = String(gameSession.numberOfHints.hallHelp)
        self.callFriends.text = String(gameSession.numberOfHints.callToFriends)
        self.totalCash.text = String(gameSession.totalCash)
        
        questionNumber.text = "Вопрос: \(String(self.currentLevel + 1))"
        
        if let height = questionLabel.getHeightLabel() {
            self.questionView.layoutIfNeeded()
            self.questionHeighConstreint.constant = height
            
        }
    }
    
}


