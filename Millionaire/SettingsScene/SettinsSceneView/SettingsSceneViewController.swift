//
//  SettingsSceneViewController.swift
//  Millionaire
//
//  Created by Ivan Konishchev on 09.08.2022.
//

import UIKit


class SettingsSceneViewController: UIViewController {
    
    var containerDelegate: MainMenuDelegate?
    
    @IBAction func asd(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(named: ColorScheme.setingsBackground.rawValue)
        self.setSettingsView()
    }
}

extension SettingsSceneViewController {
    
    fileprivate func setSettingsView() {
    // back main menu button
        let backImage = UIImageView(frame: .zero)
        backImage.image = UIImage(systemName: "hand.point.left")
        backImage.tintColor = UIColor(named: ColorScheme.settingsTint.rawValue)
        backImage.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapBackButton))
        backImage.addGestureRecognizer(tap)
        
        backImage.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(backImage)
        NSLayoutConstraint.activate([
            backImage.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 50),
            backImage.leadingAnchor.constraint(greaterThanOrEqualTo: self.view.leadingAnchor, constant: 0),
            self.view.trailingAnchor.constraint(equalTo: backImage.trailingAnchor, constant: 110),
           // self.view.bottomAnchor.constraint(greaterThanOrEqualTo: backImage.bottomAnchor, constant: 0),
            backImage.heightAnchor.constraint(equalToConstant: 30),
            backImage.widthAnchor.constraint(equalTo: backImage.heightAnchor, multiplier: 1 / 1)
        ])
      
        let easy = UIAction(title: "Легко") { _ in
            print("easy")
        }
        
        let medium = UIAction(title: "Средне") { _ in
            print("medium")
        }
        
        let hard = UIAction(title: "Сложно") { _ in
            print("hard")
        }

        let menu = UIMenu( options: .displayInline, children: [easy,medium,hard])
        
        let menuButton = UIButton(frame: .zero)
        menuButton.setTitle("Сложность", for: .normal)
        menuButton.backgroundColor = .systemGray6
        menuButton.setTitleColor(.red, for: .normal)
        menuButton.menu = menu
        menuButton.showsMenuAsPrimaryAction = true
        menuButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(menuButton)
        
        NSLayoutConstraint.activate([
            menuButton.topAnchor.constraint(equalTo: backImage.topAnchor,constant: 50),
            self.view.trailingAnchor.constraint(equalTo: menuButton.trailingAnchor, constant: 130),
            self.view.bottomAnchor.constraint(greaterThanOrEqualTo: menuButton.bottomAnchor, constant: 0),
            menuButton.heightAnchor.constraint(equalToConstant: 30),
            menuButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10)
            
            
        ])
    }

    //MARK: - delegate
    @objc func tapBackButton() {
        containerDelegate?.togglMenu()
    }
    
    fileprivate func getLabelMenu(withTitle title: String) -> UILabel {
        let label = UILabel(frame: .zero)
        
        return label
    }
    
}
