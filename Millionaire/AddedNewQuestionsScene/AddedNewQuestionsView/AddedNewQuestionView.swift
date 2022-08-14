//
//  AddedNewQuestionView.swift
//  Millionaire
//
//  Created by Ivan Konishchev on 12.08.2022.
//

import UIKit

class AddedNewQuestionView: UIViewController {

    
    weak var myTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(named: ColorScheme.background.rawValue)
        let table = UITableView(frame: .zero)
        table.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(table)
        self.myTableView = table
        myTableView.backgroundColor = UIColor(named: ColorScheme.background.rawValue)
        table.delegate = self
        table.dataSource = self
        NSLayoutConstraint.activate([
            myTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            myTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            myTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            table.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100)
        ])
        
        myTableView.register(UINib(nibName: "AddedQuestionTableCell", bundle: nil), forCellReuseIdentifier: "MyCell")
        // Do any additional setup after loading the view.
    }
    

}


extension AddedNewQuestionView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell") as? AddedQuestionTableCell else {
            preconditionFailure("Error cell")
        }
        cell.textChanged {[weak tableView] (_) in
                    DispatchQueue.main.async {
                        tableView?.beginUpdates()
                        tableView?.endUpdates()
                    }
                }
        return cell
    }
    

}
