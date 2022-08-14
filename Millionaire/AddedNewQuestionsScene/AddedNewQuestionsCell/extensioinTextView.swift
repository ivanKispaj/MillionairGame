//
//  extensioinTextView.swift
//  Millionaire
//
//  Created by Ivan Konishchev on 12.08.2022.
//

import UIKit

extension UITextView {
    
    public convenience init(frame: CGRect, with placeholder: String) {
        self.init(frame: frame)
        self.text = placeholder
        self.textColor = UIColor.systemGray6
        
    }
}
