//
//  ContainerMenuController.swift
//  Millionaire
//
//  Created by Ivan Konishchev on 09.08.2022.
//
import UIKit

class ContainerMenuController: UIViewController {
    var toggle = true
    var menuController: UIViewController!
    var settingsViewController: UIViewController!
    override func viewDidLoad() {
        super.viewDidLoad()
        createMainMenuScene()
        // Do any additional setup after loading the view.
    }

    fileprivate func createMainMenuScene() {
        let mainMenuViewController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() as! MainMenuViewController
        menuController = mainMenuViewController
        mainMenuViewController.containerDelegate = self
        view.addSubview(menuController.view)
        self.addChild(menuController)
        if settingsViewController == nil {
            
            let settingsController = SettingsSceneViewController()
            settingsController.containerDelegate = self
            settingsController.difficultyDelegate = mainMenuViewController
            settingsViewController = settingsController
            view.insertSubview(settingsViewController.view, at: 0)
            addChild(settingsViewController)
        }

    }

    fileprivate func showSettingsController(shouldMove : Bool) {
        if shouldMove {
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           usingSpringWithDamping: 0.8,
                           initialSpringVelocity: 0,
                           options: .curveEaseInOut) {
                self.menuController.view.frame.origin.x = UIScreen.main.bounds.maxX - 100
            } completion: { (finished) in
                
            }

        } else {
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           usingSpringWithDamping: 0.9,
                           initialSpringVelocity: 0.3,
                           options: .curveEaseInOut) {
                self.menuController.view.frame.origin.x = 0
            } completion: { (finished) in
                
            }
        }
    }
}

extension ContainerMenuController: MainMenuDelegate {
    
    func togglMenu() {
        self.showSettingsController(shouldMove: self.toggle)
        self.toggle.toggle()
    }
    
    
}
