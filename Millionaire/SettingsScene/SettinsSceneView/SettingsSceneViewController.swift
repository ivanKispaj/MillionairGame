//
//  SettingsSceneViewController.swift
//  Millionaire
//
//  Created by Ivan Konishchev on 09.08.2022.
//

import UIKit



class SettingsSceneViewController: UIViewController {
    
    weak var difficultyDelegate: SettingsDifficultyDelegate?
    weak var containerDelegate: MainMenuDelegate?
    weak var easySwitch: UISwitch!
    weak var middleSwitch: UISwitch!
    weak var hardSwitch: UISwitch!    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(named: ColorScheme.setingsBackground.rawValue)
        self.setSettingsView()
    }
}

//MARK: - add subview to superview

extension SettingsSceneViewController {
    
    fileprivate func setSettingsView() {
    // back main menu button
        let backImage = UIImageView(frame: .zero)
        backImage.image = UIImage(systemName: "decrease.quotelevel")
        backImage.tintColor = .cyan//UIColor(named: ColorScheme.settingsTint.rawValue)
        backImage.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapBackButton))
        backImage.addGestureRecognizer(tap)
        backImage.layer.shadowColor = UIColor.blue.withAlphaComponent(0.5).cgColor
        backImage.layer.shadowOffset = CGSize(width: 0, height: 10)
        backImage.layer.shadowRadius = 2
        backImage.backgroundColor = .blue.withAlphaComponent(0.1)
        
        let labelTitleScreen = UILabel(frame: .zero)
        labelTitleScreen.text = "Настройки"
        labelTitleScreen.textColor = UIColor(named: ColorScheme.settingsTint.rawValue)
        labelTitleScreen.font = UIFont.boldSystemFont(ofSize: 24)
        self.view.addSubview(labelTitleScreen)
        
        labelTitleScreen.translatesAutoresizingMaskIntoConstraints = false
        backImage.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(backImage)
        
        NSLayoutConstraint.activate([
            labelTitleScreen.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 50),
            backImage.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 50),
            labelTitleScreen.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 5),
            self.view.bottomAnchor.constraint(greaterThanOrEqualTo: labelTitleScreen.bottomAnchor, constant: 0),
            backImage.leadingAnchor.constraint(greaterThanOrEqualTo: labelTitleScreen.trailingAnchor, constant: 0),
            self.view.trailingAnchor.constraint(equalTo: backImage.trailingAnchor, constant: 110),
            backImage.heightAnchor.constraint(equalToConstant: 35),
            backImage.widthAnchor.constraint(equalTo: backImage.heightAnchor, multiplier: 1 / 1)
        ])
        let switchEasy = setDifficultyLevelSwitch(withTag: 0)
        let switchMiddle = setDifficultyLevelSwitch(withTag: 1)
        let switchHard = setDifficultyLevelSwitch(withTag: 2)
        
        switchEasy.isOn = true
        switchHard.isOn = false
        switchMiddle.isOn = false
        
        self.easySwitch = switchEasy
        self.middleSwitch = switchMiddle
        self.hardSwitch = switchHard
        
        let labelEasy = setDifficultyLevelLabel(withTitle: "Легко")
        let labelMiddle = setDifficultyLevelLabel(withTitle: "Средне")
        let labelHard = setDifficultyLevelLabel(withTitle: "Сложно")
        
        
        self.view.addSubview(switchEasy)
        switchEasy.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            labelEasy.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 15),
            labelHard.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 15),
            labelMiddle.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 15),
            labelEasy.centerYAnchor.constraint(equalTo: switchEasy.centerYAnchor),
            labelMiddle.centerYAnchor.constraint(equalTo: switchMiddle.centerYAnchor),
            labelHard.centerYAnchor.constraint(equalTo: switchHard.centerYAnchor),
            switchEasy.topAnchor.constraint(equalTo: backImage.bottomAnchor,constant: 50),
            switchMiddle.topAnchor.constraint(equalTo: switchEasy.bottomAnchor, constant: 10),
            switchHard.topAnchor.constraint(equalTo: switchMiddle.bottomAnchor, constant: 10),
            self.view.trailingAnchor.constraint(equalTo: switchEasy.trailingAnchor, constant: 120),
            self.view.trailingAnchor.constraint(equalTo: switchMiddle.trailingAnchor, constant: 120),
            self.view.trailingAnchor.constraint(equalTo: switchHard.trailingAnchor, constant: 120),
            switchEasy.centerXAnchor.constraint(equalTo: labelEasy.centerXAnchor),
            switchMiddle.centerXAnchor.constraint(equalTo: labelMiddle.centerXAnchor),
            switchHard.centerXAnchor.constraint(equalTo: labelHard.centerXAnchor),
            switchEasy.leadingAnchor.constraint(greaterThanOrEqualTo: labelEasy.leadingAnchor, constant: 0),
            switchMiddle.leadingAnchor.constraint(greaterThanOrEqualTo: labelMiddle.leadingAnchor, constant: 0),
            switchHard.leadingAnchor.constraint(greaterThanOrEqualTo: labelHard.leadingAnchor, constant: 0),
            self.view.bottomAnchor.constraint(greaterThanOrEqualTo: switchHard.bottomAnchor, constant: 0),
          //  self.view.bottomAnchor.constraint(greaterThanOrEqualTo: labelHard.bottomAnchor, constant: 0)

            
            
        ])
    }

    //MARK: - delegate
    @objc func tapBackButton() {
        containerDelegate?.togglMenu()
    }

   
  //MARK: - function universal swith and lable added
    fileprivate func setDifficultyLevelSwitch(withTag tag: Int) -> UISwitch {
        let switchAction = UISwitch(frame: .zero)
        switchAction.addTarget(self, action: #selector(selectedSwitch), for: .valueChanged)
        switchAction.translatesAutoresizingMaskIntoConstraints = false
        switchAction.tag = tag
        self.view.addSubview(switchAction)
        return switchAction
    }
    
    fileprivate func setDifficultyLevelLabel(withTitle title: String) -> UILabel {
        let label = UILabel(frame: .zero)
        label.textColor = UIColor(named: ColorScheme.menuLabelColor.rawValue)
        label.text = title
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(label)
        return label
    }
    
    
}


//MARK: - UISwitch action

extension SettingsSceneViewController {
    @objc func selectedSwitch(_ sender: UISwitch) {
        switch sender.tag {
        case 0:
            if sender.isOn == false && self.middleSwitch.isOn == false && self.hardSwitch.isOn == false {
                sender.isOn = true
                sender.setOn(true, animated: false)
                
                break
            }
            
            if self.middleSwitch.isOn {
                middleSwitch.isOn = false
                middleSwitch.setOn(false, animated: true)
            } else {
                self.hardSwitch.isOn = false
                self.hardSwitch.setOn(false, animated: true)
            }
            
        case 1:
            if sender.isOn == false && self.easySwitch.isOn == false && self.hardSwitch.isOn == false {
                sender.isOn = true
                sender.setOn(true, animated: false)
                break
            }
            if self.easySwitch.isOn {
                self.easySwitch.isOn = false
                self.easySwitch.setOn(false, animated: true)
            } else {
                self.hardSwitch.isOn = false
                self.hardSwitch.setOn(false, animated: true)
            }
        case 2:
            if sender.isOn == false && self.middleSwitch.isOn == false && self.easySwitch.isOn == false {
                sender.isOn = true
                sender.setOn(true, animated: false)
                break
            }
            if self.easySwitch.isOn {
                self.easySwitch.isOn = false
                self.easySwitch.setOn(false, animated: true)
            } else {
                self.middleSwitch.isOn = false
                self.middleSwitch.setOn(false, animated: true)
            }
        default:
            break
        }
        
        self.difficultyDelegate?.setDifficulty(withLevel: sender.tag)
    }
}


