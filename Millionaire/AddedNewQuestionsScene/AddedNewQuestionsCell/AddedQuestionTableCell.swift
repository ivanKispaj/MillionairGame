//
//  AddedQuestionTableCell.swift
//  Millionaire
//
//  Created by Ivan Konishchev on 12.08.2022.
//

import UIKit

class AddedQuestionTableCell: UITableViewCell, UITextViewDelegate  {

    @IBOutlet weak var textView: UITextView!
    var textChanged: ((String) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor(named: ColorScheme.background.rawValue)
        textView.delegate = self
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func textChanged(action: @escaping (String) -> Void) {
         self.textChanged = action
     }
     
     func textViewDidChange(_ textView: UITextView) {
         textChanged?(textView.text)
     }
}
