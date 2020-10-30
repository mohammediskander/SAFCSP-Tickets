//
//  Card.swift
//  Tickets
//
//  Created by Mohammed Iskandar on 23/10/2020.
//

import UIKit

class Card: UIView {

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.cornerRadius = frame.width * 0.3
    }
    
    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
        super.init(coder: coder)
        
        layer.cornerRadius = (frame.width + frame.height) * 0.025
        layer.shadowRadius = 5
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowOffset = .zero
        
    }
}
