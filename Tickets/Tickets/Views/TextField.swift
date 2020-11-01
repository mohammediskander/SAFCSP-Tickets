//
//  TextField.swift
//  Tickets
//
//  Created by Mohammed Iskandar on 31/10/2020.
//

import UIKit

class TextField: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpTextField()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpTextField()
    }
    
    func setUpTextField() {
        self.layer.cornerRadius = 5
    }
    
    func validate() {
        if let text = self.text, text.isEmpty {
            self.showError()
        }
    }
    
    func showError() {
        self.layer.borderWidth = 0.5
        self.layer.masksToBounds = true
        self.layer.borderColor = UIColor.red.cgColor
    }
}
