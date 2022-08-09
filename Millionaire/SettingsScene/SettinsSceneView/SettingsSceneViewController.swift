//
//  SettingsSceneViewController.swift
//  Millionaire
//
//  Created by Ivan Konishchev on 09.08.2022.
//

import UIKit


class SettingsSceneViewController: UIViewController {

    var containerDelegate: MainMenuDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor(named: ColorScheme.setingsBackground.rawValue)
        self.setSettingsView()
    }
  
    
    fileprivate func setSettingsView() {
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
            self.view.bottomAnchor.constraint(greaterThanOrEqualTo: backImage.bottomAnchor, constant: 0),
            backImage.heightAnchor.constraint(equalToConstant: 30),
            backImage.widthAnchor.constraint(equalTo: backImage.heightAnchor, multiplier: 1 / 1)
        ])
    }
    @objc func tapBackButton() {
        containerDelegate?.togglMenu()
    }
}

extension SettingsSceneViewController {
    

}
