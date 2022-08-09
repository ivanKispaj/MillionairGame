//
//  ExtensionUILabel.swift
//  Millionaire
//
//  Created by Ivan Konishchev on 07.08.2022.
//

import UIKit

extension UILabel {
    public func getHeightLabel() -> CGFloat? {
        guard let text = text, !text.isEmpty else { return nil }
        let size: CGSize = text.size(withAttributes: [NSAttributedString.Key.font: font as Any])
        let countRows = 1 + (size.width / (UIScreen.main.bounds.width - 20))
        numberOfLines = 0
        sizeToFit()
        return 20 + (countRows * size.height)
    }
}
