//
//  RecordCell.swift
//  Millionaire
//
//  Created by Ivan Konishchev on 07.08.2022.
//

import UIKit

class RecordCell: UITableViewCell {
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var rightAnswerLabel: UILabel!
    @IBOutlet weak var cashLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(wish record: Records) {
        self.isUserInteractionEnabled = false
        self.backgroundColor = UIColor(named: ColorScheme.background.rawValue)?.withAlphaComponent(0.5)
        self.rightAnswerLabel.textColor = .white
        self.dateLabel.textColor = .white
        self.cashLabel.textColor = .white
        self.rightAnswerLabel.text = String(record.rightAnswers)
        self.cashLabel.text = String(record.totalCash)
        self.dateLabel.text = record.date
    }
}
