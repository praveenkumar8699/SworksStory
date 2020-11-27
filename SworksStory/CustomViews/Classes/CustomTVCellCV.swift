//
//  CustomTVCellCV.swift
//  SworksStory
//
//  Created by Praveen Kumar on 27/11/20.
//

import UIKit

class CustomTVCellCV: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    func customisze() {
        
        layer.cornerRadius = 10
        layer.masksToBounds = true
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowRadius = 10
        
    }

}
