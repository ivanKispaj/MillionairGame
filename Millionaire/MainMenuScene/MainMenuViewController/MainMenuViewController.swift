//
//  MainMenuViewController.swift
//  Millionaire
//
//  Created by Ivan Konishchev on 04.08.2022.
//

import UIKit


protocol MainMenuDelegate: AnyObject {
    func togglMenu()
}

protocol SettingsDifficultyDelegate: AnyObject {
    func setDifficulty(withLevel level: Int)
}

class MainMenuViewController: UIViewController {
   
    private var difficultyLevel: DifficultyLevel = .easy
    weak var containerDelegate: MainMenuDelegate?
    weak var scrollView: UIScrollView!
    weak var imageLogo: UIImageView!
    weak var startGameLabel: UILabel!
    weak var recordsLabel: UILabel!
    weak var settingsLabel: UILabel!
    weak var addedLabel: UILabel!
    let imageLogoTopMargine: CGFloat = 120
    // для изменения отступа сверху у логотипа при изменении ориентации экрана
    weak var imageLogoTopConstraint: NSLayoutConstraint!
 
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addAllSubview()
        
    }
    
    // меняем отступ сверху для лого в зависимости от ориентации экрана
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        getNewTopAnchor()
    }
    
   
    //MARK: - Add all subview in to screen scene
    fileprivate func addAllSubview() {
        
        self.view.backgroundColor = UIColor(named: ColorScheme.background.rawValue)
        
        let scrollView = UIScrollView(frame: .zero)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .clear
        
        let imageLogo = UIImageView(frame: .zero)
        imageLogo.translatesAutoresizingMaskIntoConstraints = false
        imageLogo.image = UIImage(named: "MillionairLogo")
        
        let startGameLabel = getLabel(withTitle: MenuTitle.start)
        
        let recordsLabel = getLabel(withTitle: MenuTitle.records)
        
        let settingsLabel = getLabel(withTitle: MenuTitle.settings)
        
        let addedLabel = getLabel(withTitle: MenuTitle.addedQuestion)
        // Добавляем subview
        scrollView.addSubview(imageLogo)
        scrollView.addSubview(startGameLabel)
        scrollView.addSubview(recordsLabel)
        scrollView.addSubview(settingsLabel)
        scrollView.addSubview(addedLabel)
        self.view.addSubview(scrollView)
        
        self.recordsLabel = recordsLabel
        self.startGameLabel = startGameLabel
        self.settingsLabel = settingsLabel
        self.imageLogo = imageLogo
        self.addedLabel = addedLabel
        self.scrollView = scrollView
        self.imageLogoTopConstraint = imageLogo.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: imageLogoTopMargine)
       // self.setConstraints()
        
        NSLayoutConstraint.activate([
            imageLogoTopConstraint,
            imageLogo.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            imageLogo.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            imageLogo.widthAnchor.constraint(equalTo: imageLogo.heightAnchor, multiplier: 16 / 9)
        ])
        // констрейнты для лейбла старт игры
        NSLayoutConstraint.activate([
            startGameLabel.topAnchor.constraint(equalTo: imageLogo.bottomAnchor, constant: 50),
            startGameLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor)
        ])
        // констрейнты для лейбла рекорды
        NSLayoutConstraint.activate([
            recordsLabel.topAnchor.constraint(equalTo: startGameLabel.bottomAnchor, constant: 20),
            recordsLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
        ])
        // констрейнты для лейбла настройки
        NSLayoutConstraint.activate([
            settingsLabel.topAnchor.constraint(equalTo: recordsLabel.bottomAnchor, constant: 20),
            settingsLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
           // settingsLabel.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
            
        ])
        // констрейнты для лейбла добавления вопроса
        NSLayoutConstraint.activate([
            addedLabel.topAnchor.constraint(equalTo: settingsLabel.bottomAnchor, constant: 20),
            addedLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            addedLabel.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
        // констрейнты для скролвью
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
    
    func getLabel(withTitle title: MenuTitle) -> UILabel {
        let label = UILabel(frame: .zero)
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = UIColor(named: ColorScheme.menuLabelColor.rawValue)
        label.text = title.rawValue
        label.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(selectedMenuLine))
        label.addGestureRecognizer(tap)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }
    // меняет верхний констрейнт для лого в зависимости от ориентации экрана
    fileprivate func getNewTopAnchor() {
        if UIDevice.current.orientation.isLandscape {
            self.imageLogoTopConstraint.isActive = false
            self.imageLogoTopConstraint = imageLogo.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 10)
            self.imageLogoTopConstraint.isActive = true
            self.imageLogo.layoutIfNeeded()
        } else {
            self.imageLogoTopConstraint.isActive = false
            self.imageLogoTopConstraint = imageLogo.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: imageLogoTopMargine)
            self.imageLogoTopConstraint.isActive = true
            self.imageLogo.layoutIfNeeded()
        }
    }
    
    // Настраиваем констрейнты
    fileprivate func setConstraints() {
        // констрейнты для лого
      
        
    }
}
//MARK: - selected menu
extension MainMenuViewController {

    @objc func selectedMenuLine(_ sender: UITapGestureRecognizer? = nil) {
    // анимация нажатия кнопки
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        if let labelRecognaizer = sender?.view as? UILabel, let textLabel = labelRecognaizer.text {
            switch textLabel {
            case MenuTitle.start.rawValue:
                let gameSession = GameSessoin()
                Game.shared.gameSession = gameSession
                guard let nextVC = storyboard.instantiateViewController(withIdentifier: "GameSceneViewController") as? GameSceneViewController else { return }
                nextVC.difficultyLevel = self.difficultyLevel
                self.animateTapAndRoute(to: nextVC, animate: self.startGameLabel)
            case MenuTitle.records.rawValue:
                guard let nextVC = storyboard.instantiateViewController(withIdentifier: "RecordsViewController") as? RecordsSceneViewController else { return }
                self.animateTapAndRoute(to: nextVC, animate: self.recordsLabel)
                
            case MenuTitle.settings.rawValue:
                UIView.animate(withDuration: 0.2,
                               delay: 0 ) {
                    self.settingsLabel.layer.opacity = 0.3
                }completion: { result in
                    self.settingsLabel.layer.opacity = 1
                    self.containerDelegate?.togglMenu()

                }
            case MenuTitle.addedQuestion.rawValue:
                guard let nextVC = storyboard.instantiateViewController(withIdentifier: "AddedNewQuestions") as? AddedNewQuestionView else { return }
                self.animateTapAndRoute(to: nextVC, animate: self.addedLabel)
            default:
                break
            }
        }

    }

    private func animateTapAndRoute(to nextVC: UIViewController, animate: UILabel) {
        
        UIView.animate(withDuration: 0.2,
                       delay: 0 ) {
            animate.layer.opacity = 0.3
        }completion: { result in
                        nextVC.modalPresentationStyle = .fullScreen
                        animate.layer.opacity = 1
                        self.present(nextVC, animated: true)
        }
    }
}


extension MainMenuViewController: SettingsDifficultyDelegate {
  
    
    func setDifficulty(withLevel level: Int) {
        switch level {
        case 0:
            self.difficultyLevel = DifficultyLevel.easy
        case 1:
            self.difficultyLevel = DifficultyLevel.middle
        case 2:
            self.difficultyLevel = DifficultyLevel.hard
        default:
            break
        }
    }
}
