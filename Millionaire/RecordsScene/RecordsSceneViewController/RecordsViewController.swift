//
//  RecordsSceneViewController.swift
//  Millionaire
//
//  Created by Ivan Konishchev on 05.08.2022.
//

import UIKit

class RecordsSceneViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var titleTable: UILabel!
    private var myTableView: UITableView!
    var records: [Records]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(named: ColorScheme.background.rawValue)
        setBackgroundImage()
        
        
        self.records = Game.shared.records
        addedTableView()
        myTableView.dataSource = self
        myTableView.delegate = self
        myTableView.register(UINib(nibName: "RecordCell", bundle: nil), forCellReuseIdentifier: "RecordCell")
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let records = self.records else { return 0 }
        return records.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let records = self.records else { preconditionFailure("Empty records")}
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RecordCell", for: indexPath) as? RecordCell else {
            preconditionFailure("Error! Not  Cell!")
        }
        
        cell.setData(wish: records[indexPath.row])
        return cell
    }
}

extension RecordsSceneViewController {
    
    private func addedTableView() {
        let topView = UIView(frame: .zero)
        topView.translatesAutoresizingMaskIntoConstraints = false
        
        let backButton = UIImageView(frame: .zero)
        backButton.image = UIImage(systemName: "house")
        backButton.tintColor = UIColor.blue
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.isUserInteractionEnabled = true
        let tapHomeButton = UITapGestureRecognizer(target: self, action: #selector(backToHome))
        backButton.addGestureRecognizer(tapHomeButton)
        topView.addSubview(backButton)
        topView.addSubview(self.titleTable)
        
        self.myTableView = UITableView(frame: .zero)
        self.myTableView.translatesAutoresizingMaskIntoConstraints = false
        self.myTableView.backgroundColor = UIColor(named: ColorScheme.background.rawValue)?.withAlphaComponent(0.1)
        self.myTableView.isUserInteractionEnabled = true
        self.view.addSubview(topView)
        self.view.addSubview(myTableView)
        topView.backgroundColor = UIColor(named: ColorScheme.tabBarColor.rawValue)
        
        NSLayoutConstraint.activate([
            topView.heightAnchor.constraint(equalToConstant: 60),
            topView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 40),
            topView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            topView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            backButton.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: 20),
            backButton.centerYAnchor.constraint(equalTo: topView.centerYAnchor),
            topView.trailingAnchor.constraint(greaterThanOrEqualTo: backButton.trailingAnchor, constant: 0),
            backButton.heightAnchor.constraint(equalToConstant: 30),
            backButton.widthAnchor.constraint(equalTo: backButton.heightAnchor, multiplier: 12 / 9),
            self.titleTable.centerYAnchor.constraint(equalTo: topView.centerYAnchor),
            self.titleTable.centerXAnchor.constraint(equalTo: topView.centerXAnchor),30),
            self.myTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.myTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.myTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
            
        ])
    }
    
    private func setBackgroundImage() {
        
        let title = UILabel(frame: .zero)
        title.textColor = UIColor(named: ColorScheme.menuLabelColor.rawValue)
        title.text = "Таблица рекордов"
        title.translatesAutoresizingMaskIntoConstraints = false
        self.titleTable = title
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
    @objc func backToHome() {
        self.dismiss(animated: true)
    }
}
