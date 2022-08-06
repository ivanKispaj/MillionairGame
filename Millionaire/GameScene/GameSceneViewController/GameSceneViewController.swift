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
    weak var answerOne: UILabel!
    weak var answertwo: UILabel!
    weak var answerThree: UILabel!
    weak var answerFour: UILabel!
    weak var timerLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupGameScene()
    }

    fileprivate func setupGameScene() {
        
        guard let gameSession = Game.shared.gameSession else {return}
        
        setBackgroundImage()
        let topView = setTopView(from: gameSession)
        setMidleView(topView: topView)
        
       
        let questionLabel = UILabel(frame: .zero)
        let answerView = UIView(frame: .zero)
        
       
      
        

        
        
        
    }
   
}


// MARK: - setupGameScene

extension GameSceneViewController {
    

    fileprivate func setMidleView(topView: UIView) {
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
        self.timerLabel = timeLabel
        timerActiviti.addSubview(self.timerLabel)
        midleView.addSubview(timerActiviti)
        timerActiviti.translatesAutoresizingMaskIntoConstraints = false
        self.timerLabel.translatesAutoresizingMaskIntoConstraints = false
      
//timerActiviti.startAnimating()
        NSLayoutConstraint.activate([
            timerActiviti.centerYAnchor.constraint(equalTo: midleView.centerYAnchor),
            timerActiviti.centerXAnchor.constraint(equalTo: midleView.centerXAnchor),
            timerActiviti.widthAnchor.constraint(equalToConstant: 100),
            timerActiviti.heightAnchor.constraint(equalTo: timerActiviti.widthAnchor, multiplier: 1 / 1),
            timeLabel.centerXAnchor.constraint(equalTo: timerActiviti.centerXAnchor),
            timeLabel.centerYAnchor.constraint(equalTo: timerActiviti.centerYAnchor)
        ])
        
        
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
