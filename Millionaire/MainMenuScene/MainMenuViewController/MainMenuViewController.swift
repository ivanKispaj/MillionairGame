//
//  MainMenuViewController.swift
//  Millionaire
//
//  Created by Ivan Konishchev on 04.08.2022.
//

import UIKit

class MainMenuViewController: UIViewController {
 
    weak var scrollView: UIScrollView!
    weak var imageLogo: UIImageView!
    weak var startGameLabel: UILabel!
    weak var recordsLabel: UILabel!
    weak var settingsLabel: UILabel!
    let imageLogoTopMargine: CGFloat = 120
    // для изменения отступа сверху у логотипа при изменении ориентации экрана
    weak var imageLogoTopConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addAllSubview()
    }
    
    // меняем отступ сверху для лого в зависимости от ориентации экрана
    override func viewDidLayoutSubviews() {
        getNewTopAnchor()
    }
    
    override func viewDidAppear(_ animated: Bool) {
       
    }
    fileprivate func addAllSubview() {
        
        self.view.backgroundColor = UIColor(named: ColorScheme.background.rawValue)
        
        let scrollView = UIScrollView(frame: .zero)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .clear
        
        let imageLogo = UIImageView(frame: .zero)
        imageLogo.translatesAutoresizingMaskIntoConstraints = false
        imageLogo.image = UIImage(named: "MillionairLogo")
        
        let startGameLable = UILabel(frame: .zero)
        startGameLable.translatesAutoresizingMaskIntoConstraints = false
        startGameLable.font = UIFont.boldSystemFont(ofSize: 20)
        startGameLable.textColor = UIColor(named: ColorScheme.menuLabelColor.rawValue)
        startGameLable.text = MenuTitle.start.rawValue
        startGameLable.isUserInteractionEnabled = true
        let startGameTap = UITapGestureRecognizer(target: self, action: #selector(startGame))
        startGameLable.addGestureRecognizer(startGameTap)
        startGameLable.textAlignment = .center
        
        let recordsLable = UILabel(frame: .zero)
        recordsLable.translatesAutoresizingMaskIntoConstraints = false
        recordsLable.font = UIFont.boldSystemFont(ofSize: 20)
        recordsLable.textColor = UIColor(named: ColorScheme.menuLabelColor.rawValue)
        recordsLable.text = MenuTitle.records.rawValue
        recordsLable.isUserInteractionEnabled = true
        let recordsTap = UITapGestureRecognizer(target: self, action:  #selector(startGame))
        recordsLable.addGestureRecognizer(recordsTap)
        recordsLable.textAlignment = .center
        
        let settingsLabel = UILabel(frame: .zero)
        settingsLabel.translatesAutoresizingMaskIntoConstraints = false
        settingsLabel.font = UIFont.boldSystemFont(ofSize: 20)
        settingsLabel.textColor = UIColor(named: ColorScheme.menuLabelColor.rawValue)
        settingsLabel.text = MenuTitle.settings.rawValue
        settingsLabel.isUserInteractionEnabled = true
        let settingsTap = UITapGestureRecognizer(target: self, action:  #selector(startGame))
        settingsLabel.addGestureRecognizer(settingsTap)
        settingsLabel.textAlignment = .center
        
        // Добавляем subview
        scrollView.addSubview(imageLogo)
        scrollView.addSubview(startGameLable)
        scrollView.addSubview(recordsLable)
        scrollView.addSubview(settingsLabel)
        self.view.addSubview(scrollView)
        
        self.recordsLabel = recordsLable
        self.startGameLabel = startGameLable
        self.settingsLabel = settingsLabel
        self.imageLogo = imageLogo
        self.scrollView = scrollView
        self.imageLogoTopConstraint = imageLogo.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: imageLogoTopMargine)
        self.setConstraints()
        
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
        NSLayoutConstraint.activate([
            self.imageLogoTopConstraint,
            self.imageLogo.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor),
            self.imageLogo.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            self.imageLogo.widthAnchor.constraint(equalTo: self.imageLogo.heightAnchor, multiplier: 16 / 9)
        ])
        // констрейнты для лейбла старт игры
        NSLayoutConstraint.activate([
            self.startGameLabel.topAnchor.constraint(equalTo: self.imageLogo.bottomAnchor, constant: 50),
            self.startGameLabel.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor)
        ])
        // констрейнты для лейбла рекорды
        NSLayoutConstraint.activate([
            self.recordsLabel.topAnchor.constraint(equalTo: self.startGameLabel.bottomAnchor, constant: 20),
            self.recordsLabel.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor),
        ])
        // констрейнты для лейбла настройки
        NSLayoutConstraint.activate([
            self.settingsLabel.topAnchor.constraint(equalTo: self.recordsLabel.bottomAnchor, constant: 20),
            self.settingsLabel.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor),
            self.settingsLabel.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor)
            
        ])
        // констрейнты для скролвью
        NSLayoutConstraint.activate([
            self.scrollView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        
    }
}

extension MainMenuViewController {
    
    @objc func startGame(_ sender: UITapGestureRecognizer? = nil) {
    // анимация нажатия кнопки
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let labelRecognaizer = sender?.view as? UILabel, let textLabel = labelRecognaizer.text {
            switch textLabel {
            case MenuTitle.start.rawValue:
                let gameSession = GameSessoin()
                Game.shared.gameSession = gameSession
                guard let nextVC = storyboard.instantiateViewController(withIdentifier: "GameSceneViewController") as? GameSceneViewController else { return }
                self.animateTapAndRoute(to: nextVC, animate: self.startGameLabel)
            case MenuTitle.records.rawValue:
                guard let nextVC = storyboard.instantiateViewController(withIdentifier: "RecordsViewController") as? RecordsSceneViewController else { return }
                self.animateTapAndRoute(to: nextVC, animate: self.recordsLabel)
                
            case MenuTitle.settings.rawValue:
                print(textLabel)
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
